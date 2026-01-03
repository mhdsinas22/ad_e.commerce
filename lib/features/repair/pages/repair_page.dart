import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/warranty_info_section.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_bloc.dart';
import 'package:ad_e_commerce/features/repair/data/datasources/cloudinary_remote_datasource.dart';
import 'package:ad_e_commerce/features/repair/pages/issue_select_page.dart';
import 'package:dio/dio.dart';
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
        BlocProvider(
          create: (_) => RepairImageBloc(CloudinaryRemoteDatasource()),
        ),
        BlocProvider(
          create:
              (context) => RepairFormBloc(
                repository: RepairRepositoryImpl(
                  RepairRemoteDataSourceImpl(Supabase.instance.client),
                  CloudinaryRemoteDatasource(dio: Dio()),
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
  final _modelController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  String _selectedLocation = 'Select Location';
  // Note: Populate this list with actual locations or fetch from an API
  final List<String> _locations = [
    "Malappuram",
    "Kozhikode",
    'Select Location',
  ];

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
        child: CustomScrollView(
          slivers: [
            AppSliverAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Brand Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AppTexts.medium('Select Brand', fontSize: 18),
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
                      borderraduis: 12,
                      controller: _descriptionController,
                      hintText: 'Describe issue...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    // Upload Photo
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: AppTexts.medium("Upload Photo", fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    const RepairImagePicker(),
                    const SizedBox(height: 24),
                    // User Details
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: AppTexts.medium("Your Details: ", fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: AppTexts.medium("Name:", fontSize: 12),
                    ),

                    AppTextArea(
                      controller: _nameController,
                      hintText: 'Enter Name',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: AppTexts.medium("Mobile:", fontSize: 12),
                    ),
                    AppTextArea(
                      controller: _mobileController,
                      hintText: '+ 910000000000',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: AppTexts.medium("Email:", fontSize: 12),
                    ),
                    AppTextArea(
                      controller: _emailController,
                      hintText: 'Enter Email',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: AppTexts.medium("Location:", fontSize: 12),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:
                              _locations.contains(_selectedLocation)
                                  ? _selectedLocation
                                  : _locations.last,
                          items:
                              _locations
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedLocation = val!;
                            });
                          },
                          isExpanded: true,
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
                      padding: const EdgeInsets.symmetric(vertical: .0),
                      child: RepairSubmitButton(
                        onPressed: () {
                          final brandState = context.read<BrandBloc>().state;
                          final imageState =
                              context.read<RepairImageBloc>().state;
                          final issuestate = context.read<IssueBloc>().state;
                          context.read<RepairFormBloc>().add(
                            SubmitRepairRequest(
                              brand: brandState.selectedBrand,
                              services: issuestate.selectedIssues,
                              deviceModel: _modelController.text,
                              complaintDescription: _descriptionController.text,
                              images: imageState.images,
                              name: _nameController.text,
                              mobileNumber: _mobileController.text,
                              email: _emailController.text,
                              location: _selectedLocation,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [const SizedBox(height: 50), WarrantyInfoSection()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildLabel(String label) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8),
  //     child: Text(
  //       label,
  //       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  //     ),
  //   );
  // }
}
