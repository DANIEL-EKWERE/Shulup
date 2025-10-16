import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/home_controller.dart';
import '../models/actiongrid_item_model.dart';

// ignore_for_file: must_be_immutable
class ActiongridItemWidget extends StatelessWidget {
  ActiongridItemWidget(
    this.actiongridItemModelObj, {
    Key? key,
    this.onTapRowdropoffone,
  }) : super(key: key);

  ActiongridItemModel actiongridItemModelObj;

  var controller = Get.find<HomeController>();

  VoidCallback? onTapRowdropoffone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapRowdropoffone?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
        decoration: actiongridItemModelObj.id!.value == '2' || actiongridItemModelObj.id!.value == '4' ? AppDecoration.fillPrimaryx.
        copyWith(
          
          borderRadius: BorderRadiusStyle.roundedBorder6,
        ) : AppDecoration.outlinePrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder6,
        ) ,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => CustomImageView(
                imagePath: actiongridItemModelObj.dropOffOne!.value,
                height: 16.h,
                width: 16.h,
              ),
            ),
            SizedBox(width: 10),
            Obx(
              () => Text(
                actiongridItemModelObj.dropoff!.value,
                style: actiongridItemModelObj.id!.value == '2' || actiongridItemModelObj.id!.value == '4' ? CustomTextStyles.titleSmallwhiteA700 : CustomTextStyles.titleSmallBlack900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
