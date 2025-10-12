import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelectionDialog extends StatelessWidget {
  final List<String> options;
  final Function(int,String)? onSelected;
  final String? title;

  const CustomSelectionDialog({
    Key? key,
    required this.options,
    this.onSelected,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 选项列表
          ...options.asMap().entries.map((entry) {
            int index = entry.key;
            String option = entry.value;
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    onSelected?.call(index,option);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                if (index < options.length - 1)
                  Container(
                    height: 0.5,
                    color: Colors.grey[300],
                  ),
              ],
            );
          }).toList(),
          // 分隔线
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          // 取消按钮
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '取消',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
