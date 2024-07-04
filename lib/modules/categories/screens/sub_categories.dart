import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/modules/categories/widgets/sub_category_card.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'add_sub_category_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, required this.categoriesModel});
  final CategoriesModel categoriesModel;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final searchController = TextEditingController();
  String searchText = '';

  Stream<QuerySnapshot> get _database {
    CollectionReference storesRef = _firebaseFirestore
        .collection(AppCollections.categories)
        .doc(widget.categoriesModel.id)
        .collection(AppCollections.subcategories);

    Query query = storesRef;

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryService>(builder: (context, categoryService, __) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Sub Categories for ${widget.categoriesModel.name}'),
        ),
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
                child: AddSubCategoryScreen(
                    categoriesModel: widget.categoriesModel),
                isLoading: categoryService.isLoading,
                heading: "Add sub category");
          },
          label: Text(
            "Add New Sub Category",
            style: AppStyles.urbanist14Smbd.copyWith(color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.height,
              Text('All Sub Categories for ${widget.categoriesModel.name}',
                  style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              30.height,
              StreamBuilder(
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
                          LocalSvgIcon(
                            Assets.icons.bulk.searchStatus1,
                            size: 100,
                          ),
                          const Text("No categories to show"),
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
                              BoxConstraints(maxWidth: context.getWidth(.9)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("S/N", style: AppStyles.urbanist16Md),
                              10.width,
                              Text("Image", style: AppStyles.urbanist16Md),
                              20.width,
                              Expanded(
                                  child: Text("Name",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Sizes",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Colors",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Item Prices",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Design Price",
                                      style: AppStyles.urbanist16Md)),
                              20.width,
                              Expanded(
                                  child: Text("Specifications",
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
                                SubCategoriesModel.fromDocumentSnapshot(data);
                            return SubCategoryCard(
                              data: category,
                              index: index,
                              categoryService: categoryService,
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
