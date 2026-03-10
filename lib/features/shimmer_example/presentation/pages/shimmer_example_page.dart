import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../core/widgets/shimmers/product_card_shimmer.dart';
import '../../../../core/widgets/shimmers/profile_shimmer.dart';
import '../../../../core/widgets/shimmers/shimmer_list.dart';

class ShimmerExamplePage extends StatefulWidget {
  const ShimmerExamplePage({super.key});

  @override
  State<ShimmerExamplePage> createState() => _ShimmerExamplePageState();
}

class _ShimmerExamplePageState extends State<ShimmerExamplePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate initial loading
    _simulateLoading();
  }

  void _simulateLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shimmer Loaders'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _simulateLoading,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Products'),
              Tab(text: 'List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Profile Tab
            _isLoading
                ? const SingleChildScrollView(child: ProfileShimmer())
                : const Center(child: Text('Profile Loaded!')),

            // Products Grid Tab
            _isLoading
                ? GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) => const ProductCardShimmer(),
                )
                : const Center(child: Text('Products Loaded!')),

            // Standard List Tab
            _isLoading
                ? const ShimmerList(
                  itemCount: 8,
                  padding: EdgeInsets.all(16),
                  itemBuilder: ListTileShimmer(),
                )
                : const Center(child: Text('List Items Loaded!')),
          ],
        ),
      ),
    );
  }
}
