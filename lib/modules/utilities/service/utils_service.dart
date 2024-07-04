import 'package:chapa_admin/handlers/base_change_notifier.dart';
import 'package:chapa_admin/modules/utilities/models/color_model.dart';
import 'package:chapa_admin/modules/utilities/models/size_model.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UtilitiesService extends BaseChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> deleteColor({required String id}) async {
    try {
      setLoading = true;
      await _firestore.collection(AppCollections.colors).doc(id).delete();
      handleSuccess(message: "Deleted");
      return true;
    } catch (e) {
      handleError(message: e.toString());
      return false;
    }
  }

  Future<bool> deleteSize({required String id}) async {
    try {
      setLoading = true;
      await _firestore.collection(AppCollections.sizes).doc(id).delete();
      handleSuccess(message: "Deleted");
      return true;
    } catch (e) {
      handleError(message: e.toString());
      return false;
    }
  }

  Future<bool> addColor({required String name}) async {
    try {
      setLoading = true;
      final now = Utils.getTimestamp();
      await _firestore.collection(AppCollections.colors).doc().set({
        'name': name,
        'added': now,
      });
      handleSuccess();
      return true;
    } catch (e) {
      handleError(message: e.toString());
      return false;
    }
  }

  Future<bool> addSize({required String name}) async {
    try {
      setLoading = true;
      final now = Utils.getTimestamp();
      await _firestore.collection(AppCollections.sizes).doc().set({
        'name': name,
        'added': now,
      });
      handleSuccess();
      return true;
    } catch (e) {
      handleError(message: e.toString());
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
