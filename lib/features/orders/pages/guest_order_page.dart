import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/primary_button.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestOrdersUI extends StatelessWidget {
  final bool isScaffold;
  const GuestOrdersUI({super.key, this.isScaffold = false});

  @override
  Widget build(BuildContext context) {
    return isScaffold
        ? Scaffold(
          appBar: AppBar(backgroundColor: AppColors.pureWhite),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long, size: 80, color: Colors.grey),

                    const SizedBox(height: 20),
                    const Text(
                      "No Orders Yet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Login to view your order history",
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        height: 50,
                        borderRadius: 12,
                        needBorder: true,
                        fontcolor: AppColors.pureBlack,
                        backgroudColor: AppColors.pureWhite,
                        onPressed: () {
                          context.pushNamed(
                            RouteNames.phoneLogin,
                            extra: {
                              "redirectRoute": RouteNames.mainShell,
                              "redirectArgs": null,
                            },
                          );
                        },
                        text: "Login",
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// CREATE ACCOUNT
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        height: 50,
                        borderRadius: 12,
                        onPressed: () {
                          context.pushNamed(
                            RouteNames.signup,
                            extra: {
                              "redirectRoute": RouteNames.mainShell,
                              "redirectArgs": null,
                            },
                          );
                        },
                        text: "Create Account",
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// CONTINUE SHOPPING
                    TextButton(
                      onPressed: () {
                        context.goNamed(RouteNames.mainShell);
                      },
                      child: AppTexts.regular("Continue Shopping"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        : Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey),

                  const SizedBox(height: 20),

                  const Text(
                    "No Orders Yet",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Login to view your order history",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      height: 50,
                      borderRadius: 12,
                      needBorder: true,
                      fontcolor: AppColors.pureBlack,
                      backgroudColor: AppColors.pureWhite,
                      onPressed: () {
                        context.pushNamed(
                          RouteNames.phoneLogin,
                          extra: {
                            "redirectRoute": RouteNames.mainShell,
                            "redirectArgs": null,
                          },
                        );
                      },
                      text: "Login",
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// CREATE ACCOUNT
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      height: 50,
                      borderRadius: 12,
                      onPressed: () {
                        context.pushNamed(
                          RouteNames.signup,
                          extra: {
                            "redirectRoute": RouteNames.mainShell,
                            "redirectArgs": null,
                          },
                        );
                      },
                      text: "Create Account",
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// CONTINUE SHOPPING
                  TextButton(
                    onPressed: () {
                      context.read<BottomNavBloc>().add(
                        BottomNavChanged(index: 0),
                      );
                      context.goNamed(RouteNames.mainShell);
                    },
                    child: AppTexts.regular("Continue Shopping"),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
