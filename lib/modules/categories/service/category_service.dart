import 'dart:typed_data';
import 'package:chapa_admin/handlers/base_change_notifier.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/printing_services/models/prints.dart';
import 'package:chapa_admin/modules/utilities/models/color_model.dart';
import 'package:chapa_admin/modules/utilities/models/size_model.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryService extends BaseChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<SubCategoriesModel> _subCategories = [];
  List<SubCategoriesModel> get subCategories => _subCategories;

  Future<List<SubCategoriesModel>> getSubcategories(categoryId) async {
    try {
      setLoading = true;
      QuerySnapshot querySnapshot = await _firestore
          .collection(AppCollections.categories)
          .doc(categoryId)
          .collection(AppCollections.subcategories)
          .get();
      List<SubCategoriesModel> printingServices = querySnapshot.docs.map((doc) {
        return SubCategoriesModel.fromDocumentSnapshot(doc);
      }).toList();
      _subCategories = printingServices;
      notifyListeners();
      handleSuccess();
      return printingServices;
    } catch (e) {
      handleError(message: e.toString());
      throw Exception('Failed to get suubs: $e');
    }
  }

  List<PrintingServicesModel> getPrintServices(List<String> ids) {
    try {
      print("====== ${ids}");
      List<PrintingServicesModel> res =
          _prints.where((cat) => ids.contains(cat.id)).toList();
      print("====== ${res}");
      return res;
    } catch (e) {
      return [];
    }
  }

  List<PrintingServicesModel> _prints = [];
  List<PrintingServicesModel> get printingServices => _prints;

  Future<List<PrintingServicesModel>> getPrintingServices() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(AppCollections.printingServices).get();
      List<PrintingServicesModel> printingServices =
          querySnapshot.docs.map((doc) {
        return PrintingServicesModel.fromDocumentSnapshot(doc);
      }).toList();
      _prints = printingServices;
      notifyListeners();
      return printingServices;
    } catch (e) {
      throw Exception('Failed to get colors: $e');
    }
  }

  Future<void> deleteCategory({required String id}) async {
    try {
      setLoading = true;
      await _firestore.collection(AppCollections.categories).doc(id).delete();
      handleSuccess(message: "Deleted");
    } catch (e) {
      handleError(message: e.toString());
      throw Exception('Failed to add category: $e');
    }
  }

  Future<void> deleteSubcategory({
    required String id,
    required String catId,
  }) async {
    try {
      setLoading = true;
      await _firestore
          .collection(AppCollections.categories)
          .doc(catId)
          .collection(AppCollections.subcategories)
          .doc(id)
          .delete();
      handleSuccess(message: "Deleted");
    } catch (e) {
      handleError(message: e.toString());
      throw Exception('Failed to add category: $e');
    }
  }

  Future<String> uploadImage(Uint8List imageFile, String fileNames) async {
    try {
      // Validate the image
      // if (!isValidImage(imageFile)) {
      //   throw Exception('Invalid image data');
      // }
      setLoading = true;

      final now = Utils.getTimestamp();
      // Upload the image
      Reference storageReference = _storage
          .ref()
          .child("Uploads")
          .child("Categories")
          .child('/$fileNames$now');
      final metaData = SettableMetadata(
        contentType: 'image/jpeg',
      );
      UploadTask uploadTask = storageReference.putData(imageFile, metaData);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      if (snapshot.state == TaskState.success) {
        String imageUrl = await snapshot.ref.getDownloadURL();
        print("Image uploaded successfully: $imageUrl");
        setLoading = false;
        return imageUrl;
      } else {
        setLoading = false;
        throw Exception('Upload failed');
      }
    } catch (e) {
      print('Failed to upload image: $e');
      setLoading = false;
      throw Exception('Failed to upload image: $e');
    }
  }

  bool isValidImage(Uint8List data) {
    if (data.length < 10) return false;
    if (data[0] == 0xFF && data[1] == 0xD8) {
      return true;
    }
    return false;
  }

  List<Map<String, dynamic>> convertPrintToMap(
      List<PrintingServicesModel> printServices) {
    return printServices.map((order) {
      return {
        "id": order.id,
        "name": order.name,
        "price": order.price,
        "unit": order.unit,
        "added": order.added,
      };
    }).toList();
  }

  Future<void> addCategory(
      {required String name,
      required String designPrice,
      required List<String> printServices,
      required String imageUrl}) async {
    try {
      setLoading = true;
      // final services = convertPrintToMap(printServices);
      final now = Utils.getTimestamp();
      await _firestore.collection(AppCollections.categories).doc().set({
        'name': name,
        'url': imageUrl,
        'design_price': designPrice,
        'printing_services': printServices,
        'added': now,
      });
      handleSuccess();
    } catch (e) {
      handleError(message: e.toString());
      throw Exception('Failed to add category: $e');
    }
  }

  Future<bool> editSubcategory({
    required String catId,
    required String subcatId,
    required String name,
    required String designPrice,
    required String lowPrice,
    required String highPrice,
    required String description,
    required String specifications,
    required List<String> images,
    required List<String> colors,
    required List<String> sizes,
  }) async {
    try {
      setLoading = true;
      // final docId = Utils.generateRandomDocIDs();
      final now = Utils.getTimestamp();
      await _firestore
          .collection(AppCollections.categories)
          .doc(catId)
          .collection(AppCollections.subcategories)
          .doc(subcatId)
          .update({
        'name': name,
        'description': description,
        'design_price': designPrice,
        'higher_price': highPrice,
        'lower_price': lowPrice,
        'specifications': specifications,
        'images': images,
        'color': colors,
        'size': sizes,
        'updated': now,
        'reviews': [],
      });
      handleSuccess();
      return true;
    } catch (e) {
      handleError(message: e.toString());
      // throw Exception('Failed to add category: $e');
      return false;
    }
  }

  Future<bool> addSubcategory({
    required String catId,
    required String name,
    required String designPrice,
    required String lowPrice,
    required String highPrice,
    required String description,
    required String specifications,
    required List<String> images,
    required List<String> colors,
    required List<String> sizes,
  }) async {
    try {
      setLoading = true;
      // final docId = Utils.generateRandomDocIDs();
      final now = Utils.getTimestamp();
      await _firestore
          .collection(AppCollections.categories)
          .doc(catId)
          .collection(AppCollections.subcategories)
          .doc()
          .set({
        // 'id': docId,
        'cat_id': catId,
        'name': name,
        'description': description,
        'design_price': designPrice,
        'higher_price': highPrice,
        'lower_price': lowPrice,
        'specifications': specifications,
        'images': images,
        'color': colors,
        'size': sizes,
        'added': now,
        'reviews': [],
      });
      handleSuccess();
      return true;
    } catch (e) {
      handleError(message: e.toString());
      // throw Exception('Failed to add category: $e');
      return false;
    }
  }

  List<ColorModel> _colors = [];
  List<ColorModel> get colors => _colors;

  Future<List<ColorModel>> getColors() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(AppCollections.colors).get();
      List<ColorModel> colors = querySnapshot.docs.map((doc) {
        return ColorModel.fromDocumentSnapshot(doc);
      }).toList();
      _colors = colors;
      notifyListeners();
      return colors;
    } catch (e) {
      throw Exception('Failed to get colors: $e');
    }
  }

  List<SizeModel> _sizes = [];
  List<SizeModel> get sizes => _sizes;

  Future<List<SizeModel>> getSizes() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(AppCollections.sizes).get();
      List<SizeModel> sizes = querySnapshot.docs.map((doc) {
        return SizeModel.fromDocumentSnapshot(doc);
      }).toList();
      _sizes = sizes;
      notifyListeners();
      return sizes;
    } catch (e) {
      throw Exception('Failed to get colors: $e');
    }
  }
}
