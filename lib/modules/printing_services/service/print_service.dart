import 'package:chapa_admin/handlers/base_change_notifier.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrintingService extends BaseChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> editPrintService({
    required String id,
    required String name,
    required String price,
    required String unit,
  }) async {
    try {
      setLoading = true;
      final now = Utils.getTimestamp();
      await _firestore
          .collection(AppCollections.printingServices)
          .doc(id)
          .update({
        'name': name,
        'price': price,
        'unit': unit,
        'updated_at': now,
      });
      handleSuccess();
      return true;
    } catch (e) {
      handleError(message: e.toString());
      return false;
    }
  }

  Future<bool> deletePrintService({required String id}) async {
    try {
      setLoading = true;
      await _firestore
          .collection(AppCollections.printingServices)
          .doc(id)
          .delete();
      handleSuccess(message: "Deleted");
      return true;
    } catch (e) {
      handleError(message: e.toString());
      return false;
    }
  }

  Future<bool> addPrintService({
    required String name,
    required String price,
    required String unit,
  }) async {
    try {
      setLoading = true;
      final now = Utils.getTimestamp();
      await _firestore.collection(AppCollections.printingServices).doc().set({
        'name': name,
        'price': price,
        'unit': unit,
        'added': now,
      });
      handleSuccess();
      return true;
    } catch (e) {
      handleError(message: e.toString());
      return false;
    }
  }
}
