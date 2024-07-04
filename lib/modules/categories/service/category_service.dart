import 'dart:typed_data';
import 'package:chapa_admin/handlers/base_change_notifier.dart';
import 'package:chapa_admin/modules/utilities/models/color_model.dart';
import 'package:chapa_admin/modules/utilities/models/size_model.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryService extends BaseChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<void> addCategory(
      {required String name,
      required String designPrice,
      required String imageUrl}) async {
    try {
      setLoading = true;
      // final docId = Utils.generateRandomDocIDs();
      final now = Utils.getTimestamp();
      await _firestore.collection(AppCollections.categories).doc().set({
        // 'id': docId,
        'name': name,
        'url': imageUrl,
        'design_price': designPrice,
        'added': now,
      });
      handleSuccess();
    } catch (e) {
      handleError(message: e.toString());
      throw Exception('Failed to add category: $e');
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
