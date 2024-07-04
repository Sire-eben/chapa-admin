import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/utilities/models/size_model.dart';
import 'package:chapa_admin/modules/utilities/screens/add_size.dart';
import 'package:chapa_admin/modules/utilities/service/utils_service.dart';
import 'package:chapa_admin/modules/utilities/widgets/size_card.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class SizesScreen extends StatefulWidget {
  const SizesScreen({super.key});

  @override
  State<SizesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<SizesScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final searchController = TextEditingController();
  String searchText = '';

  Stream<QuerySnapshot> get _database {
    CollectionReference storesRef =
        _firebaseFirestore.collection(AppCollections.sizes);

    Query query = storesRef;

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.primary,
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          AlertDialogHandler.showAlertDialog(
            context: context,
            child: const AddSizeDialog(),
            isLoading: false,
            heading: "Add Size",
          );
        },
        label: Text(
          "Add Size",
          style: AppStyles.urbanist14Smbd.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.height,
            Text('Sizes',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            30.height,
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: Shadows.universal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder(
                stream: _database,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: PageLoader());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(context.getHeight(.3)),
                          LocalSvgIcon(
                            Assets.icons.bulk.size,
                            size: 100,
                            color: AppColors.primary,
                          ),
                          const Text("No sizes to show"),
                          Gap(context.getHeight(.3)),
                        ],
                      ),
                    );
                  } else {
                    final List<QueryDocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: context.getWidth(.4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text("S/N",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Name",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Date Added",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Actions",
                                      style: AppStyles.urbanist16Md)),
                            ],
                          ),
                        ),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: documents.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            final data = documents[index];
                            final category =
                                SizeModel.fromDocumentSnapshot(data);
                            return SizeCard(
                              data: category,
                              utilitiesService: locator<UtilitiesService>(),
                              index: index,
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
