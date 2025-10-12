import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomInputDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String unit;
  final String? initialValue;
  final Function(String)? onConfirmed;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  const CustomInputDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.unit,
    this.initialValue,
    this.onConfirmed,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  late TextEditingController _textController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue ?? '');
    _focusNode = FocusNode();

    // 延迟聚焦，确保对话框完全显示后再聚焦
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onConfirm() {
    final value = _textController.text.trim();
    if (value.isNotEmpty) {
      Get.back();
      widget.onConfirmed?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题部分
              Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // 输入区域
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      // 输入框
                      Flexible(
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            keyboardType: widget.keyboardType,
                            inputFormatters: widget.inputFormatters ??
                                [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.hintText ?? '請輸入',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[400],
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onSubmitted: (_) => _onConfirm(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // 单位
                      Text(
                        widget.unit,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),
              // 按钮区域
              Container(
                height: 50,
                child: Row(
                  children: [
                    // 取消按钮
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              '取消',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                 
                    // 确定按钮
                    Expanded(
                      child: InkWell(
                        onTap: _onConfirm,
                        child: Container(
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              '確定',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF4ECDC4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
