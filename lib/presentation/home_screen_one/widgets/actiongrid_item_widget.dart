import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/home_one_controller.dart';
import '../models/actiongrid_item_model.dart';

// ignore_for_file: must_be_immutable
class ActiongridItemWidget extends StatelessWidget {
  ActiongridItemWidget(this.actiongridItemModelObj, {Key? key})
    : super(key: key);

  ActiongridItemModel actiongridItemModelObj;

  var controller = Get.find<HomeOneController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
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
          Obx(
            () => Text(
              actiongridItemModelObj.dropoff!.value,
              style: CustomTextStyles.titleSmallBlack900,
            ),
          ),
        ],
      ),
    );
  }
}
