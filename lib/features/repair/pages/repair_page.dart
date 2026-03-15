import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/utils/validators.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/warranty_info_section.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_bloc.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_event.dart';
import 'package:ad_e_commerce/features/repair/data/datasources/repair_storage_service.dart';
import 'package:ad_e_commerce/features/repair/pages/issue_select_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../bloc/brand/brand_bloc.dart';
import '../bloc/repair_form/repair_form_bloc.dart';
import '../bloc/repair_image/repair_image_bloc.dart';
import '../bloc/service/service_bloc.dart';
import '../data/datasources/repair_remote_data_source.dart';
import '../data/repositories/repair_repository_impl.dart';
import '../widgets/app_text_area.dart';
import '../widgets/brand_grid.dart';
import '../widgets/repair_image_picker.dart';
import '../widgets/repair_submit_button.dart';

class RepairPage extends StatelessWidget {
  const RepairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ServiceBloc()),
        BlocProvider(create: (_) => BrandBloc()..add(LoadBrands())),
        BlocProvider(create: (_) => IssueBloc()),
        BlocProvider(create: (_) => RepairImageBloc(RepairStorageService())),
        BlocProvider(
          create:
              (context) => RepairFormBloc(
                repository: RepairRepositoryImpl(
                  RepairRemoteDataSourceImpl(Supabase.instance.client),
                  RepairStorageService(),
                ),
              ),
        ),
      ],
      child: const RepairPageView(),
    );
  }
}

class RepairPageView extends StatefulWidget {
  const RepairPageView({super.key});

  @override
  State<RepairPageView> createState() => _RepairPageViewState();
}

class _RepairPageViewState extends State<RepairPageView> {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedLocation;
  // Note: Populate this list with actual locations or fetch from an API
  final List<String> _locations = ["Malappuram", "Kozhikode"];

  @override
  void dispose() {
    _modelController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RepairFormBloc, RepairFormState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            _modelController.clear();
            _descriptionController.clear();
            _nameController.clear();
            _mobileController.clear();
            _emailController.clear();
            setState(() {
              _selectedLocation = 'Select Location';
            });
            context.read<RepairImageBloc>().add(ClearImages());
            context.read<IssueBloc>().add(ClearIssues());
            context.read<BrandBloc>().add(ClearBrand());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Repair request submitted successfully!'),
              ),
            );
          } else if (state.status == FormStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Submission failed'),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              AppSliverAppBar(showSearchIcon: true),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Brand Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: AppTexts.medium(
                              'Select Brand',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const BrandGrid(),
                          const SizedBox(height: 24),
                          // 2. Services Section
                          AppTexts.medium('Select Services', fontSize: 18),
                          const SizedBox(height: 4),
                          AppTexts.medium(
                            '(Tap to select multiple issues)',
                            fontSize: 10,
                          ),
                          const SizedBox(height: 12),
                          IssueSelectPage(),
                          const SizedBox(height: 10),
                          // 3. Repair Request Form
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 3.0,
                            ),
                            child: AppTexts.medium(
                              'Repair Request Form',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AppTextArea(
                            borderraduis: 20,
                            controller: _modelController,
                            hintText: 'Enter your device model',
                            maxLines: 1,
                          ),
                          const SizedBox(height: 16),
                          // Complaint Description
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: AppTexts.medium(
                              "Complaint Description:",
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          AppTextArea(
                            height: 131,
                            borderraduis: 12,
                            controller: _descriptionController,
                            hintText: 'Describe issue...',
                            maxLines: 4,
                            validator:
                                (value) => Validators.minLength(value, 10),
                          ),
                          const SizedBox(height: 20),
                          // Upload Photo
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: AppTexts.medium(
                              "Upload Photo",
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const RepairImagePicker(),
                          const SizedBox(height: 24),
                          // User Details
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: AppTexts.medium(
                              "Your Details: ",
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10.0,
                            ),
                            child: AppTexts.medium("Name:", fontSize: 12),
                          ),

                          AppTextArea(
                            controller: _nameController,
                            hintText: 'Enter Name',
                            maxLines: 1,
                            validator:
                                (value) => Validators.requiredField(
                                  value,
                                  fieldName: 'Name',
                                ),
                          ),
                          const SizedBox(height: 16),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10.0,
                            ),
                            child: AppTexts.medium("Mobile:", fontSize: 12),
                          ),
                          AppTextArea(
                            keyboardType: TextInputType.phone,
                            controller: _mobileController,
                            hintText: '+ 910000000000',
                            maxLines: 1,
                            validator: Validators.phone,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10.0,
                            ),
                            child: AppTexts.medium("Email:", fontSize: 12),
                          ),
                          AppTextArea(
                            validator: Validators.email,
                            controller: _emailController,
                            hintText: 'Enter Email',
                            maxLines: 1,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10.0,
                            ),
                            child: AppTexts.medium("Location:", fontSize: 12),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(59),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,

                                  size: 30,
                                ),
                                dropdownColor: AppColors.pureWhite,
                                value:
                                    _locations.contains(_selectedLocation)
                                        ? _selectedLocation
                                        : null,
                                hint: Text(
                                  "Select Location",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                isExpanded: true,
                                items:
                                    _locations.isEmpty
                                        ? []
                                        : _locations
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors
                                                            .pureBlack, // normal item color
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedLocation = val;
                                  });
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: AppTexts.medium(
                              " *Note: Price will be quoted via Phone/WhatsApp ",
                              fontSize: 10,
                              color: AppColors.grayColor,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: RepairSubmitButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (_selectedLocation == null ||
                                    _selectedLocation!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please select location'),
                                    ),
                                  );
                                  return;
                                }

                                final currentUser =
                                    Supabase
                                        .instance
                                        .client
                                        .auth
                                        .currentUser
                                        ?.id;
                                final brandState =
                                    context.read<BrandBloc>().state;
                                final imageState =
                                    context.read<RepairImageBloc>().state;
                                final issuestate =
                                    context.read<IssueBloc>().state;
                                if (imageState.images.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please upload at least one photo',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                final user =
                                    Supabase.instance.client.auth.currentUser;
                                user == null
                                    ? Helpers.showAuthBottomSheet(
                                      context,
                                      redirectRoute: RouteNames.mainShell,
                                      redirectArgs: {"index": 3},
                                    )
                                    : context.read<RepairFormBloc>().add(
                                      SubmitRepairRequest(
                                        userid: currentUser.toString(),
                                        brand: brandState.selectedBrand,
                                        services: issuestate.selectedIssues,
                                        deviceModel: _modelController.text,
                                        complaintDescription:
                                            _descriptionController.text,
                                        images: imageState.images,
                                        name: _nameController.text,
                                        mobileNumber: _mobileController.text,
                                        email: _emailController.text,
                                        location: _selectedLocation ?? "",
                                      ),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        WarrantyInfoSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
