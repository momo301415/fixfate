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
  RxList<ChatTopicGroup> topicGroups = <ChatTopicGroup>[].obs;
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
    groupMessagesByTopicAndSession();
  }

  void groupMessagesByTopicAndSession() {
    final Map<String, List<ChatMessageModel>> grouped = {};

    for (final msg in allMessages) {
      final topicId = msg.topicId?.value ?? '未知主題';
      final sessionId = msg.sessionId?.value ?? '';
      final groupKey = '${topicId}_${sessionId}';

      grouped.putIfAbsent(groupKey, () => []).add(msg);
    }

    for (final messages in grouped.values) {
      messages.sort((a, b) {
        final aTime = DateTime.tryParse(a.timestamp?.value ?? '');
        final bTime = DateTime.tryParse(b.timestamp?.value ?? '');
        if (aTime == null || bTime == null) return 0;
        return aTime.compareTo(bTime);
      });
    }

    final groups = grouped.entries.map((entry) {
      final messages = entry.value;
      final firstMsg = messages.first;
      final lastMsg = messages.last;
      final lastTime = DateTime.tryParse(lastMsg.timestamp?.value ?? '');

      return ChatTopicGroup(
        topicId: firstMsg.topicId?.value ?? '未知主題',
        sessionId: firstMsg.sessionId?.value ?? '',
        messages: messages,
        lastMessageTime: lastTime ?? DateTime.now(),
        messageCount: messages.length,
      );
    }).toList();

    groups.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

    topicGroups.value = groups;
    _groupByTimeOffset();
    print('🔍 分組完成：共 ${groups.length} 個對話群組');
  }

  void _groupByTimeOffset() {
    final now = DateTime.now();
    final Map<int, List<ChatTopicGroup>> timeGroups = {};

    for (final group in topicGroups) {
      final diff = now.difference(group.lastMessageTime);
      final dayOffset = diff.inDays;

      timeGroups.putIfAbsent(dayOffset, () => []).add(group);
    }

    final sections = timeGroups.entries.map((entry) {
      return ChatGroupedSection(
        dayOffset: entry.key,
        messages: entry.value,
      );
    }).toList();

    // 按時間排序：最近的在前
    sections.sort((a, b) => a.dayOffset.compareTo(b.dayOffset));

    groupedSections.value = sections;
  }

  String dayLabel(int dayOffset) {
    if (dayOffset == 0) {
      return '今天';
    } else if (dayOffset == 1) {
      return '昨天';
    } else {
      return '${dayOffset}天前';
    }
  }

  void continueConversation(ChatTopicGroup group) {
    print('📱 點擊繼續對話 - Topic: ${group.topicId}');

    // 改用 Get.back(result) 而不是 Get.toNamed
    Get.back(result: {
      'topicId': group.topicId,
      'messages': group.messages,
    });
  }
}
