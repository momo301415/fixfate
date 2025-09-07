# 自定义对话框组件

本目录包含了一套完整的自定义对话框组件，用于处理常见的用户交互场景。

## 组件列表

### 1. CustomSelectionDialog - 选择对话框
**文件**: `custom_selection_dialog.dart`

**功能**: 用于显示选项列表供用户选择，如性别选择等。

**特点**:
- 支持自定义选项列表
- 可选的标题显示
- 选项间有分隔线
- 底部有取消按钮
- 点击选项或取消都会关闭对话框

**参数**:
- `options`: 选项列表
- `onSelected`: 选择回调函数
- `title`: 可选标题

### 2. CustomDatePickerDialog - 日期选择对话框
**文件**: `custom_date_picker_dialog.dart`

**功能**: 用于选择出生日期等日期信息。

**特点**:
- 年、月、日三个滚动选择器
- 自动处理月份天数变化
- 可设置年份范围
- 支持初始日期设置
- 标题栏带关闭按钮
- 底部确定按钮

**参数**:
- `title`: 对话框标题
- `initialDate`: 初始日期
- `onDateSelected`: 日期选择回调
- `startYear`: 起始年份
- `endYear`: 结束年份

### 3. CustomInputDialog - 输入对话框
**文件**: `custom_input_dialog.dart`

**功能**: 用于输入数值信息，如身高、体重等。

**特点**:
- 大字体数值输入
- 单位显示
- 标题和副标题
- 取消/确定按钮
- 自动聚焦输入框
- 支持键盘提交

**参数**:
- `title`: 主标题
- `subtitle`: 副标题
- `unit`: 单位
- `initialValue`: 初始值
- `onConfirmed`: 确认回调
- `keyboardType`: 键盘类型
- `hintText`: 提示文字

### 4. DialogUtils - 工具类
**文件**: `dialog_utils.dart`

**功能**: 提供便捷的静态方法来调用各种对话框。

**方法**:
- `showSelectionDialog()`: 显示选择对话框
- `showDatePickerDialog()`: 显示日期选择对话框
- `showInputDialog()`: 显示输入对话框
- `showGenderSelectionDialog()`: 显示性别选择对话框
- `showHeightInputDialog()`: 显示身高输入对话框
- `showWeightInputDialog()`: 显示体重输入对话框
- `showBirthDatePickerDialog()`: 显示出生日期选择对话框

## 使用示例

### 基本用法

```dart
import 'dialog_utils.dart';

// 性别选择
DialogUtils.showGenderSelectionDialog(
  onSelected: (gender) {
    print('选择的性别: $gender');
  },
);

// 身高输入
DialogUtils.showHeightInputDialog(
  initialValue: '170',
  onConfirmed: (height) {
    print('输入的身高: $height cm');
  },
);

// 出生日期选择
DialogUtils.showBirthDatePickerDialog(
  onDateSelected: (date) {
    print('选择的日期: ${date.year}-${date.month}-${date.day}');
  },
);
```

### 自定义用法

```dart
// 自定义选择对话框
DialogUtils.showSelectionDialog(
  title: '选择运动类型',
  options: ['跑步', '游泳', '骑车', '健身'],
  onSelected: (option) {
    print('选择的运动: $option');
  },
);

// 自定义输入对话框
DialogUtils.showInputDialog(
  title: '请输入目标步数',
  subtitle: '设定每日步数目标',
  unit: '步',
  hintText: '8000',
  onConfirmed: (steps) {
    print('目标步数: $steps');
  },
);
```

## 设计特点

1. **统一的视觉风格**: 所有对话框都采用相同的设计语言，包括圆角、颜色、字体等。

2. **响应式布局**: 对话框会根据内容自动调整大小，适配不同屏幕。

3. **用户体验优化**: 
   - 输入对话框自动聚焦
   - 日期选择器智能处理月份天数
   - 支持键盘操作
   - 点击外部区域可关闭

4. **易于扩展**: 组件设计灵活，可以轻松添加新的参数和功能。

5. **类型安全**: 使用强类型参数，减少运行时错误。

## 依赖

- Flutter SDK
- GetX (用于导航和状态管理)

## 注意事项

1. 确保项目中已经集成了 GetX 包
2. 所有对话框都使用 `Get.dialog()` 显示，确保在 GetX 环境中使用
3. 日期选择器的年份范围可以根据需要调整
4. 输入对话框默认只允许数字和小数点输入，可通过 `inputFormatters` 参数自定义

## 完整示例

查看 `dialog_example.dart` 文件获取完整的使用示例。