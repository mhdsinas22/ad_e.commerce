import 'dart:io';

import 'package:ad_e_commerce/features/repair/bloc/repairImage/repair_image_bloc.dart';
import 'package:ad_e_commerce/features/repair/bloc/repairImage/repair_image_event.dart';
import 'package:ad_e_commerce/features/repair/bloc/repairImage/repair_image_state.dart';
import 'package:ad_e_commerce/features/repair/widgets/add_image_tile.dart';
import 'package:ad_e_commerce/features/repair/widgets/image_source_sheet.dart';
import 'package:ad_e_commerce/features/repair/widgets/image_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepairImagePicker extends StatelessWidget {
  const RepairImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairImageBloc, RepairImageState>(
      builder: (context, state) {
        final blocContext = context; // ⭐ SAVE CONTEXT
        return SizedBox(
          height: 90,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AddImageTile(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder:
                          (context) => ImageSourceSheet(
                            onCameraTap: () {
                              Navigator.pop(context);
                              blocContext.read<RepairImageBloc>().add(
                                PickImageFromCamera(),
                              );
                            },
                            onGalleryTap: () {
                              Navigator.pop(context);
                              blocContext.read<RepairImageBloc>().add(
                                PickImageFromGallery(),
                              );
                            },
                          ),
                    );
                  },
                );
              }
              final File image = state.images[index - 1];
              return ImageTile(
                image: image,
                onRemove: () {
                  context.read<RepairImageBloc>().add(
                    RemoveRepairImage(index - 1),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemCount: state.images.length + 1,
          ),
        );
      },
    );
  }
}
