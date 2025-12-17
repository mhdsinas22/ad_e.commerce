import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsBloc(),
      child: const _UserDetailsView(),
    );
  }
}

class _UserDetailsView extends StatefulWidget {
  const _UserDetailsView();

  @override
  State<_UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<_UserDetailsView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<UserDetailsBloc, UserDetailsState>(
        listener: (context, state) {
          if (state.status == UserDetailsStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Failed to save details'),
                  backgroundColor: Colors.red,
                ),
              );
          } else if (state.status == UserDetailsStatus.saved) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Profile Saved Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            // Navigate to Home or Dashboard
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _NameInput(),
                  const SizedBox(height: 16),
                  const _EmailInput(),
                  const SizedBox(height: 16),
                  const _PasswordInput(),
                  const SizedBox(height: 32),
                  const _SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDetailsForm_nameInput_textField'),
          onChanged:
              (name) => context.read<UserDetailsBloc>().add(
                UserDetailsNameChanged(name),
              ),
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDetailsForm_emailInput_textField'),
          onChanged:
              (email) => context.read<UserDetailsBloc>().add(
                UserDetailsEmailChanged(email),
              ),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDetailsForm_emailInput_textField'),
          onChanged:
              (email) => context.read<UserDetailsBloc>().add(
                UserDetailsEmailChanged(email),
              ),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Password';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        );
      },
    );
  }
}
// class _GenderDropdown extends StatelessWidget {
//   const _GenderDropdown();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserDetailsBloc, UserDetailsState>(
//       buildWhen: (previous, current) => previous.gender != current.gender,
//       builder: (context, state) {
//         return DropdownButtonFormField<String>(
//           key: const Key('userDetailsForm_genderInput_dropdown'),
//           value: state.gender == 'Select Gender' ? null : state.gender,
//           onChanged: (gender) {
//             if (gender != null) {
//               context.read<UserDetailsBloc>().add(
//                 UserDetailsGenderChanged(gender),
//               );
//             }
//           },
//           items:
//               ['Male', 'Female', 'Other']
//                   .map(
//                     (label) =>
//                         DropdownMenuItem(value: label, child: Text(label)),
//                   )
//                   .toList(),
//           decoration: const InputDecoration(
//             labelText: 'Gender',
//             border: OutlineInputBorder(),
//             prefixIcon: Icon(Icons.people),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please select your gender';
//             }
//             return null;
//           },
//         );
//       },
//     );
//   }
// }

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      builder: (context, state) {
        return state.status == UserDetailsStatus.saving
            ? const Center(child: CircularProgressIndicator())
            : FilledButton(
              key: const Key('userDetailsForm_save_raisedButton'),
              onPressed: () {
                // We need to access form state to validate, but here we challenge the separation.
                // Usually the button is part of the form widget or we pass the key.
                // For this structure, we can just trigger the event and handle validation in Bloc or pass the key down.
                // The prompt asks for clean UI/Logic separation.
                // I'll assume the parent Form handles validation via a button callback if I moved button up, or I can find ancestor Form.
                // But simpler: I will access the form via `Form.of(context)` if I am inside Form.
                // Wait, `_SaveButton` is inside `Form`.
                if (Form.of(context).validate()) {
                  context.read<UserDetailsBloc>().add(
                    const UserDetailsSubmit(),
                  );
                }
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save Details'),
            );
      },
    );
  }
}
