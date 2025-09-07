import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dialog_utils.dart';

/// 对话框使用示例
class DialogExample extends StatefulWidget {
  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  String selectedGender = '請選擇';
  String selectedHeight = '請輸入';
  String selectedWeight = '請輸入';
  String selectedBirthDate = '請選擇';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('對話框使用示例'),
        backgroundColor: Color(0xFF4ECDC4),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 性别选择示例
            _buildExampleItem(
              title: '性別選擇',
              value: selectedGender,
              onTap: () {
                DialogUtils.showGenderSelectionDialog(
                  onSelected: (index, gender) {
                    setState(() {
                      selectedGender = gender;
                    });
                  },
                );
              },
            ),
            
            SizedBox(height: 16),
            
            // 身高输入示例
            _buildExampleItem(
              title: '身高輸入',
              value: selectedHeight == '請輸入' ? selectedHeight : '$selectedHeight cm',
              onTap: () {
                DialogUtils.showHeightInputDialog(
                  initialValue: selectedHeight == '請輸入' ? '' : selectedHeight,
                  onConfirmed: (height) {
                    setState(() {
                      selectedHeight = height;
                    });
                  },
                );
              },
            ),
            
            SizedBox(height: 16),
            
            // 体重输入示例
            _buildExampleItem(
              title: '體重輸入',
              value: selectedWeight == '請輸入' ? selectedWeight : '$selectedWeight kg',
              onTap: () {
                DialogUtils.showWeightInputDialog(
                  initialValue: selectedWeight == '請輸入' ? '' : selectedWeight,
                  onConfirmed: (weight) {
                    setState(() {
                      selectedWeight = weight;
                    });
                  },
                );
              },
            ),
            
            SizedBox(height: 16),
            
            // 出生日期选择示例
            _buildExampleItem(
              title: '出生日期選擇',
              value: selectedBirthDate,
              onTap: () {
                DialogUtils.showBirthDatePickerDialog(
                  onDateSelected: (date) {
                    setState(() {
                      selectedBirthDate = '${date.year}年${date.month}月${date.day}日';
                    });
                  },
                );
              },
            ),
            
            SizedBox(height: 32),
            
            // 自定义选择对话框示例
            ElevatedButton(
              onPressed: () {
                DialogUtils.showSelectionDialog(
                  title: '選擇運動類型',
                  options: ['跑步', '游泳', '騎車', '健身', '瑜伽'],
                  onSelected: (index, option) {
                    Get.snackbar(
                      '選擇結果',
                      '您選擇了：$option',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4ECDC4),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('自定義選擇對話框'),
            ),
            
            SizedBox(height: 16),
            
            // 自定义输入对话框示例
            ElevatedButton(
              onPressed: () {
                DialogUtils.showInputDialog(
                  title: '請輸入目標步數',
                  subtitle: '設定每日步數目標',
                  unit: '步',
                  hintText: '8000',
                  onConfirmed: (steps) {
                    Get.snackbar(
                      '設定成功',
                      '目標步數：$steps 步',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('自定義輸入對話框'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildExampleItem({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: value.contains('請') ? Colors.grey[500] : Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}