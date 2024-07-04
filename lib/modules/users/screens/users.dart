import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/modules/users/models/user.dart';
import 'package:chapa_admin/modules/users/widgets/user_card.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/app_collections.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final searchController = TextEditingController();
  String searchText = '';

  Stream<QuerySnapshot> get _database {
    CollectionReference storesRef =
        _firebaseFirestore.collection(AppCollections.users);

    Query query = storesRef;

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.height,
          Text('All Users',
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
                        Assets.icons.bulk.user,
                        size: 100,
                      ),
                      const Text("No users to show"),
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
                          Text("Image", style: AppStyles.urbanist16Md),
                          Gap(context.getWidth(.1)),
                          Expanded(
                              child: Text("First Name",
                                  style: AppStyles.urbanist16Md)),
                          30.width,
                          Expanded(
                              child: Text("Last Name",
                                  style: AppStyles.urbanist16Md)),
                          30.width,
                          Expanded(
                              child:
                                  Text("Email", style: AppStyles.urbanist16Md)),
                          30.width,
                          Expanded(
                              child: Text("Phone Number",
                                  style: AppStyles.urbanist16Md)),
                          30.width,
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
                        final user = UserModel.fromDocumentSnapshot(data);
                        return UserCard(data: user);
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
