import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k53_controller.dart';
import 'models/expandablelist2_item_model.dart';
import 'models/in_tab_model.dart';
import 'widgets/expandablelist2_item_widget.dart';

// ignore_for_file: must_be_immutable
class InTabPage extends StatelessWidget {
  InTabPage({Key? key})
      : super(
          key: key,
        );

  K53Controller controller = Get.put(K53Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 18.h,
      ),
      child: Column(
        children: [_buildExpandablelist2()],
      ),
    );
  }

  /// Section Widget
  Widget _buildExpandablelist2() {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller
                .k53ModelObj.value.expandablelist2ItemList.value.length,
            itemBuilder: (context, index) {
              Expandablelist2ItemModel model = controller
                  .k53ModelObj.value.expandablelist2ItemList.value[index];
              return Expandablelist2ItemWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }
}
