import 'package:ad_e_commerce/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ad_e_commerce/features/home/domain/enitites/models/product_model.dart';
import 'package:ad_e_commerce/features/home/domain/enitites/models/product_stock_model.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final SupabaseClient supabase;

  ProductRemoteDatasourceImpl(this.supabase);

  // ---------------- ADD PRODUCT ----------------
  @override
  Future<void> addProduct(ProductModel model) async {
    try {
      await supabase.from('products').insert(model.toMap());
    } catch (e) {
      throw Exception('Add product failed: $e');
    }
  }

  // ---------------- UPDATE PRODUCT ----------------
  @override
  Future<void> updateProduct(ProductModel model) async {
    try {
      final response =
          await supabase
              .from('products')
              .update(model.toUpdateMap())
              .eq('id', model.id!)
              .select();
      print("UPDATE RESPONSE => $response");
    } catch (e) {
      throw Exception('Update product failed: $e');
    } finally {}
  }

  // ---------------- DELETE PRODUCT ----------------
  @override
  Future<void> deleteProduct(String id) async {
    try {
      await supabase.from('products').delete().eq('id', id);
    } catch (e) {
      throw Exception('Delete product failed: $e');
    }
  }

  // ---------------- GET PRODUCTS ----------------
  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await supabase
        .from('products')
        .select('''
    *,
    product_stocks(*),
    product_warranties(
      id,
      product_id,
      warranty_type_id,
      start_date,
      end_date,
      duration_text,
      warranty_types (
        id,
        name
      )
    )
  ''')
        .order('created_at', ascending: false);

    // .order('created_at', ascending: false);
    // if (response. != null) {
    //   throw Exception(response.error!.message);
    // }

    final data = response as List;

    return data.map((json) => ProductModel.fromMap(json)).toList();
  }
  // ================= PRODUCT STOCKS =================

  @override
  Future<void> addProductStocks(List<ProductStockModel> stocks) async {
    final rows = stocks.map((e) => e.toMap()).toList();
    await supabase.from('product_stocks').insert(rows);
  }

  @override
  Future<void> deleteProductStocks(String productId) async {
    await supabase.from('product_stocks').delete().eq('product_id', productId);
  }

  @override
  Future<List<ProductStockModel>> getProductStocks(String productId) async {
    final data = await supabase
        .from('product_stocks')
        .select()
        .eq('product_id', productId);

    return (data as List)
        .map((json) => ProductStockModel.fromMap(json))
        .toList();
  }

  // ---------------- GET PRODUCTS WITH STOCK ----------------
  @override
  Future<List<Map<String, dynamic>>> getProductsWithStocks() async {
    final data = await supabase.from('products').select('*, product_stocks(*)');

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Future<void> updateProductStocks(List<ProductStockModel> stocks) async {
    try {
      for (final stock in stocks) {
        await supabase
            .from("product_stocks")
            .upsert(stock.toMap(), onConflict: 'product_id, store_name');
      }
    } catch (e) {
      throw Exception('Update product stock failed: $e');
    }
  }

  @override
  Future<List<Product>> getFlashSaleProducts() async {
    try {
      final response = await supabase
          .from("products")
          .select()
          .eq("tag", "Flash Sale");
      return response.map<Product>((e) => ProductModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception("Failed to load flash sale products :-${e.toString()}");
    }
  }
}
