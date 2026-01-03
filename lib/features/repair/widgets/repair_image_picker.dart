import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/repair_image/repair_image_bloc.dart';

class RepairImagePicker extends StatelessWidget {
  const RepairImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairImageBloc, RepairImageState>(
      builder: (context, state) {
        return SizedBox(
          height: 77,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.images.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () => _showPickerBottomSheet(context),
                  child: Container(
                    width: 77,
                    height: 67,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: AppColors.pureBlack,
                    ),
                  ),
                );
              }
              final image = state.images[index - 1];
              return Stack(
                children: [
                  Container(
                    width: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        context.read<RepairImageBloc>().add(RemoveImage(index));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  context.read<RepairImageBloc>().add(
                    const PickImage(ImageSource.gallery),
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  context.read<RepairImageBloc>().add(
                    const PickImage(ImageSource.camera),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
