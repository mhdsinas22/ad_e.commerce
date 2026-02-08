import 'package:ad_admin_side/features/product/data/datasources/product_warranty_datasoruce.dart/product_warranty_datasource.dart';
import 'package:ad_admin_side/features/product/data/models/warranty/prodcut_warranty_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ProductWarrantyRemoteDataSourceImpl
    implements ProductWarrantyRemoteDataSource {
  final SupabaseClient supabase;

  ProductWarrantyRemoteDataSourceImpl(this.supabase);

  @override
  Future<void> insertProductWarranties(
    List<ProductWarrantyModel> warranties,
  ) async {
    if (warranties.isEmpty) return;

    final data = warranties.map((e) => e.toJson()).toList();

    await supabase.from('product_warranties').insert(data);
  }

  @override
  Future<List<ProductWarrantyModel>> getProductWarranties(
    String productId,
  ) async {
    final res = await supabase
        .from('product_warranties')
        .select()
        .eq('product_id', productId);

    final List list = res as List;

    return list
        .map((e) => ProductWarrantyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> deleteProductWarranties(String productId) async {
    await supabase
        .from('product_warranties')
        .delete()
        .eq('product_id', productId);
  }
}
