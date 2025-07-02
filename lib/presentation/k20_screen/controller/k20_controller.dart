import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k20_screen/models/chat_message_model.dart';
import '../../../core/app_export.dart';
import '../models/k20_model.dart';

/// A controller class for the K20Screen.
///
/// This class manages the state of the K20Screen, including the
/// current k20ModelObj
class K20Controller extends GetxController {
  Rx<K20Model> k20ModelObj = K20Model().obs;
  final gc = Get.find<GlobalController>();

  @override
  void onReady() {
    super.onReady();
    getHistory();
  }

  RxList<ChatMessageModel> allMessages = <ChatMessageModel>[].obs;
  RxList<ChatGroupedSection> groupedSections = <ChatGroupedSection>[].obs;

  Future<void> getHistory() async {
    try {
      LoadingHelper.show();
      final payload = {
        "action": "history",
        "user_id": gc.apiId.value,
        "rag_type": "health"
      };

      var res = await ApiAwsService().postJson(Api.chatHistory, payload);
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        loadFromApiResponse(res);
      }
    } catch (e) {
      LoadingHelper.hide();
      print(e);
      // handle error
    }
  }

  void loadFromApiResponse(Map<String, dynamic> responseJson) {
    final List<dynamic> history = responseJson['history'] ?? [];
    allMessages.value = history
        .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
    groupMessagesByDay();
  }

  void groupMessagesByDay() {
    final now = DateTime.now();
    final Map<int, List<ChatMessageModel>> grouped = {};

    for (final msg in allMessages) {
      final ts = DateTime.tryParse(msg.timestamp?.value ?? '');
      if (ts == null) continue;

      final daysAgo = now.difference(ts).inDays;
      final key = daysAgo;

      grouped.putIfAbsent(key, () => []).add(msg);
    }

    final sortedKeys = grouped.keys.toList()..sort();

    groupedSections.value = sortedKeys.map((day) {
      return ChatGroupedSection(
        dayOffset: day,
        messages: grouped[day]!,
      );
    }).toList();
  }
}

class ChatGroupedSection {
  final int dayOffset; // 0: 今天, 1: 昨天, ..., 999: 更久前
  final List<ChatMessageModel> messages;

  ChatGroupedSection({required this.dayOffset, required this.messages});
}

String dayLabel(int dayOffset) {
  if (dayOffset == 0) return '今天';
  if (dayOffset == 1) return '1天前';
  if (dayOffset <= 999) return '過去 $dayOffset 天前';

  return '更久前';
}
