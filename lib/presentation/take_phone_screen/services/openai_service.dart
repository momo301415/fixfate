import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../models/food_nutrition_model.dart';

/// OpenAI API服务类
class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1';
  static const String _model = 'gpt-4o';
  
  final Dio _dio;
  final Logger _logger = Logger();
  
  // 从环境变量或配置中获取API Key
  String? _apiKey;

  OpenAIService({String? apiKey}) : _dio = Dio() {
    _apiKey = apiKey;
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_apiKey != null) {
            options.headers['Authorization'] = 'Bearer $_apiKey';
          }
          options.headers['Content-Type'] = 'application/json';
          handler.next(options);
        },
        onError: (error, handler) {
          _logger.e('OpenAI API Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  /// 设置API Key
  void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  /// 将图片文件转换为base64
  Future<String> _fileToBase64(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      _logger.e('Error converting file to base64: $e');
      throw Exception('Failed to convert image to base64');
    }
  }

  /// 将Uint8List转换为base64
  String _bytesToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  /// 获取图片的MIME类型
  String _getImageMimeType(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }

  /// 构建食物分析的prompt
  String _buildFoodAnalysisPrompt() {
    return '''
请分析这些图片中的食物，并返回详细的营养信息。请按照以下JSON格式返回结果：

{
  "foods": [
    {
      "food_name": "食物名称",
      "calories": 卡路里数值(数字),
      "protein": 蛋白质含量(克，数字),
      "carbohydrates": 碳水化合物含量(克，数字),
      "fat": 脂肪含量(克，数字),
      "fiber": 纤维素含量(克，数字),
      "description": "食物描述和备注"
    }
  ],
  "total_calories": 总卡路里(数字),
  "total_protein": 总蛋白质(克，数字),
  "total_carbohydrates": 总碳水化合物(克，数字),
  "total_fat": 总脂肪(克，数字),
  "total_fiber": 总纤维素(克，数字),
  "analysis_note": "整体分析说明"
}

要求：
1. 识别图片中的所有食物
2. 估算每种食物的分量
3. 提供准确的营养成分数据
4. 如果有多张图片，请合并分析所有食物
5. 营养数据请基于实际食物分量估算
6. 只返回JSON格式，不要其他文字说明
''';
  }

  /// 分析食物图片
  Future<FoodAnalysisResult> analyzeFoodImages(List<dynamic> images) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('OpenAI API Key not set');
    }

    if (images.isEmpty) {
      throw Exception('No images provided');
    }

    try {
      // 构建消息内容
      List<Map<String, dynamic>> content = [
        {
          "type": "text",
          "text": _buildFoodAnalysisPrompt(),
        }
      ];

      // 添加图片
      for (var image in images) {
        String base64Image;
        String mimeType = 'image/jpeg';

        if (image is File) {
          base64Image = await _fileToBase64(image);
          mimeType = _getImageMimeType(image.path);
        } else if (image is Uint8List) {
          base64Image = _bytesToBase64(image);
        } else if (image is String) {
          // 假设是base64字符串
          base64Image = image;
        } else {
          throw Exception('Unsupported image type: ${image.runtimeType}');
        }

        content.add({
          "type": "image_url",
          "image_url": {
            "url": "data:$mimeType;base64,$base64Image",
            "detail": "high"
          }
        });
      }

      final requestData = {
        "model": _model,
        "messages": [
          {
            "role": "user",
            "content": content,
          }
        ],
        "max_tokens": 2000,
        "temperature": 0.1,
      };

      _logger.i('Sending request to OpenAI API...');
      
      final response = await _dio.post(
        '/chat/completions',
        data: requestData,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final content = responseData['choices'][0]['message']['content'];
        
        _logger.i('OpenAI API Response: $content');

        // 解析JSON响应
        try {
          // 清理响应内容，移除可能的markdown格式
          String cleanContent = content.trim();
          if (cleanContent.startsWith('```json')) {
            cleanContent = cleanContent.substring(7);
          }
          if (cleanContent.endsWith('```')) {
            cleanContent = cleanContent.substring(0, cleanContent.length - 3);
          }
          cleanContent = cleanContent.trim();

          final jsonData = json.decode(cleanContent);
          return FoodAnalysisResult.fromJson(jsonData);
        } catch (e) {
          _logger.e('Error parsing JSON response: $e');
          _logger.e('Raw content: $content');
          throw Exception('Failed to parse nutrition analysis result');
        }
      } else {
        throw Exception('OpenAI API request failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('Dio error: ${e.message}');
      if (e.response != null) {
        _logger.e('Response data: ${e.response?.data}');
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('error')) {
          final errorMessage = errorData['error']['message'] ?? 'Unknown API error';
          throw Exception('OpenAI API Error: $errorMessage');
        }
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      _logger.e('Unexpected error: $e');
      throw Exception('Failed to analyze food images: $e');
    }
  }

  /// 测试API连接
  Future<bool> testConnection() async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      return false;
    }

    try {
      final response = await _dio.get('/models');
      return response.statusCode == 200;
    } catch (e) {
      _logger.e('API connection test failed: $e');
      return false;
    }
  }
}

/// OpenAI服务的GetX绑定
class OpenAIServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenAIService>(() => OpenAIService());
  }
}