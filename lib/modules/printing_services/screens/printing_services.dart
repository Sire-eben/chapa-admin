import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/printing_services/models/prints.dart';
import 'package:chapa_admin/modules/printing_services/service/print_service.dart';
import 'package:chapa_admin/modules/printing_services/widgets/print_card.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'add_service.dart';

class PrintingServices extends StatefulWidget {
  const PrintingServices({super.key});

  @override
  State<PrintingServices> createState() => _PrintingServicesState();
}

class _PrintingServicesState extends State<PrintingServices> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final searchController = TextEditingController();
  String searchText = '';

  Stream<QuerySnapshot> get _database {
    CollectionReference storesRef =
        _firebaseFirestore.collection(AppCollections.printingServices);

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
            child: const AddPrintingServiceDialog(),
            isLoading: false,
            heading: "Add service",
          );
        },
        label: Text(
          "Add Service",
          style: AppStyles.urbanist14Smbd.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.height,
            Text('Printing Services',
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
                            Assets.icons.bulk.printer,
                            size: 100,
                            color: AppColors.primary,
                          ),
                          const Text("No services to show"),
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
                                  child: Text("Price(${AppStrings.naira})",
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
                            final color =
                                PrintingServicesModel.fromDocumentSnapshot(
                                    data);
                            return PrintCard(
                              data: color,
                              index: index,
                              printingService: locator<PrintingService>(),
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
