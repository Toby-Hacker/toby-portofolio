import 'dart:convert';

import 'package:http/http.dart' as http;

class ResendEmailService {
  ResendEmailService({
    required this.endpoint,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String endpoint;
  final http.Client _client;

  Future<void> sendContactMessage({
    required String replyToEmail,
    required String mobile,
    required String message,
  }) async {
    final response = await _client.post(
      Uri.parse(endpoint),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': replyToEmail,
        'mobile': mobile,
        'message': message,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw Exception(_readErrorMessage(response));
  }

  void dispose() {
    _client.close();
  }

  String _readErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        final message = body['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message;
        }
      }
    } catch (_) {
      // Fall back to a generic HTTP error below.
    }

    return 'Request failed with status ${response.statusCode}.';
  }
}
