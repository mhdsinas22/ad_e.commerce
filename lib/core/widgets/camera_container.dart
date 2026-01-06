import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/features/repair/bloc/repair_image/repair_image_bloc.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CameraContainer extends StatelessWidget {
  const CameraContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairImageBloc, RepairImageState>(
      builder: (context, state) {
        final hasImage = state.images.isNotEmpty;
        return InkWell(
          onTap: () {
            _showPickerBottomSheet(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child:
                hasImage
                    ? Image.file(
                      state.images.last, // 🔥 single image
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    )
                    : DottedBorder(
                      options: const CircularDottedBorderOptions(
                        color: AppColors.primaryBlue,
                        strokeWidth: 2,
                        dashPattern: [6, 6],
                      ),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 32,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }

  void _showPickerBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  parentContext.read<RepairImageBloc>().add(
                    const PickSingleImage(ImageSource.gallery),
                  );
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  parentContext.read<RepairImageBloc>().add(
                    const PickImage(ImageSource.camera),
                  );
                  Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
