import 'dart:io';

import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/domain/entities/user_entity.dart';
import 'package:ad_e_commerce/features/profile/bloc/edit_profile_bloc.dart';
import 'package:ad_e_commerce/features/profile/bloc/edit_profile_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/edit_profile_state.dart';
import 'package:ad_e_commerce/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ad_e_commerce/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:ad_e_commerce/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:ad_e_commerce/features/profile/domain/usecases/upload_image_usecase.dart';
import 'package:ad_e_commerce/features/profile/widgets/profile_header.dart';
import 'package:ad_e_commerce/features/profile/widgets/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Manual Dependency Injection for this feature
    final supabaseClient = Supabase.instance.client;
    final remoteDataSource = ProfileRemoteDataSourceImpl(supabaseClient);
    final repository = ProfileRepositoryImpl(remoteDataSource);
    final getProfileUseCase = GetProfileUseCase(repository);
    final updateProfileUseCase = UpdateProfileUseCase(repository);
    final uploadProfileImageUseCase = UploadProfileImageUseCase(repository);

    return BlocProvider(
      create:
          (context) => EditProfileBloc(
            getProfileUseCase: getProfileUseCase,
            updateProfileUseCase: updateProfileUseCase,
            uploadProfileImageUseCase: uploadProfileImageUseCase,
          )..add(FetchProfileEvent(supabaseClient.auth.currentUser!.id)),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _populateFields(UserEntity user) {
    if (_nameController.text.isEmpty) _nameController.text = user.username;
    if (_usernameController.text.isEmpty) {
      _usernameController.text = user.username;
    }
    if (_phoneController.text.isEmpty) _phoneController.text = user.phone;
    if (_emailController.text.isEmpty) _emailController.text = user.email;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && mounted) {
      context.read<EditProfileBloc>().add(
        PickImageEvent(File(pickedFile.path)),
      );
    }
  }

  void _saveChanges() {
    final currentUser = context.read<EditProfileBloc>().state.user;
    if (currentUser == null) return;

    final updatedUser = UserEntity(
      userId: currentUser.userId,
      email: _emailController.text,
      username: _usernameController.text,
      phone: _phoneController.text,
      imageUrl: currentUser.imageUrl,
    );

    context.read<EditProfileBloc>().add(UpdateProfileEvent(updatedUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Center(
          child: CircularArrowButton(
            iconSize: 22,
            size: 45,
            iconColor: Colors.black,
            icon: Icons.arrow_back,
            backgroundColor: Color(0xFFF5F6FA), // Light grey from image
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: AppTexts.bold("Profile", fontSize: 18, color: Colors.black),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "An error occurred"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == EditProfileStatus.loading && state.user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.user != null) {
            _populateFields(state.user!);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ProfileHeader(
                  imageUrl: state.user?.imageUrl,
                  imageFile: state.selectedImage,
                  onEditTap: _pickImage,
                ),
                const SizedBox(height: 40),

                ProfileTextField(
                  label: "User Name",
                  controller: _usernameController,
                ),
                const SizedBox(height: 24),

                ProfileTextField(label: "Name", controller: _nameController),
                const SizedBox(height: 24),

                ProfileTextField(
                  label: "Phone Number",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                ProfileTextField(
                  label: "Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                ),

                const SizedBox(height: 60),

                SizedBox(
                  width: double.infinity,
                  height: 56, // Tall button
                  child: ElevatedButton(
                    onPressed: state.isSubmitting ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0055FF), // Bright blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child:
                        state.isSubmitting
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              "Save Changes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
