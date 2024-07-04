import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/modules/users/models/user.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/cached_image_widget.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.data,
    // required this.userService,
  });
  final UserModel data;
  // final UserService userService;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: context.getWidth(.4),
        // constraints: BoxConstraints(maxWidth: context.getWidth(.4)),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: Shadows.universal,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            // locator<NavigationService>().chapaNavigatorKey.currentState?.push(
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               SubCategoriesScreen(categoriesModel: data)),
            //     );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedImageWidget(
                imageUrl: data.image,
                height: 40,
                borderRadius: 1,
              ),
              Gap(context.getWidth(.1)),
              Expanded(
                  child: Text(data.firstname, style: AppStyles.urbanist14Md)),
              30.width,
              Expanded(
                  child: Text(data.lastname, style: AppStyles.urbanist14Md)),
              30.width,
              Expanded(child: Text(data.email, style: AppStyles.urbanist14Md)),
              30.width,
              Expanded(child: Text(data.phone, style: AppStyles.urbanist14Md)),
              30.width,
              Expanded(child: Text(Utils().formatDate(data.created_at))),
              20.width,
              Expanded(
                  child: Row(
                children: [
                  LocalSvgIcon(Assets.icons.linear.eye),
                  10.width,
                  LocalSvgIcon(Assets.icons.linear.edit),
                  10.width,
                  InkWell(
                      // onTap: () {
                      //   AlertDialogHandler.showDeleteDialog(
                      //     context: context,
                      //     isLoading: categoryService.isLoading,
                      //     onpressed: () async {
                      //       await categoryService.deleteCategory(id: data.id);
                      //       locator<NavigationService>().goBack();
                      //     },
                      //   );
                      // },
                      child: LocalSvgIcon(Assets.icons.linear.trash)),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
