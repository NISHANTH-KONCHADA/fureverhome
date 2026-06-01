import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeminiChatSheet extends StatefulWidget {
  const GeminiChatSheet({super.key});

  @override
  State<GeminiChatSheet> createState() => _GeminiChatSheetState();
}

class _GeminiChatSheetState extends State<GeminiChatSheet> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  // TODO — PUT YOUR REAL API KEY HERE
  final String geminiApiKey = "AIzaSyB9QiyQvk7J78MKTNkDysZmJhfOC2_YhVY";

  @override
  void initState() {
    super.initState();
    // Initial greeting
    _messages.add({
      'role': 'assistant',
      'content': 'Hello! How can I help you?'
    });
  }

  Future<void> sendMessage(String message) async {
  if (message.trim().isEmpty) return;

  setState(() {
    _loading = true;
    _messages.add({'role': 'user', 'content': message});
  });

  // Auto scroll
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  });

  try {
    final contents = _messages.map((msg) {
      return {
        "role": msg["role"] == "user" ? "user" : "model",
        "parts": [
          {"text": msg["content"]},
        ],
      };
    }).toList();

    final response = await http.post(
      Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"
      ),
      headers: {
        "Content-Type": "application/json",
        "x-goog-api-key": geminiApiKey,
      },
      body: jsonEncode({
        "systemInstruction": {
          "parts": [
            {"text": "Answer briefly and clearly."},
          ]
        },
        "contents": contents,
        "generationConfig": {
          "maxOutputTokens": 200,
          "temperature": 0.7,
        }
      }),
    );

    String reply = "No response from model.";

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print("GEMINI RAW RESPONSE: $data");

      // ✅ SAFE PARSING — NEVER CRASHES
      try {
        final candidates = data["candidates"];
        if (candidates != null &&
            candidates is List &&
            candidates.isNotEmpty) {
          final parts = candidates[0]["content"]?["parts"];
          if (parts != null &&
              parts is List &&
              parts.isNotEmpty &&
              parts[0]["text"] != null) {
            reply = parts[0]["text"];
          } else {
            reply = "No text generated.";
          }
        } else if (data["promptFeedback"] != null) {
          reply = "Blocked: ${data["promptFeedback"]["blockReason"]}";
        }
      } catch (e) {
        reply = "Parsing error: $e";
      }

      setState(() {
        _messages.add({"role": "assistant", "content": reply});
        _controller.clear();
      });
    } else {
      final error = jsonDecode(response.body);
      final message = error["error"]?["message"] ?? "Unknown API error";

      setState(() {
        _messages.add({
          "role": "assistant",
          "content": "API Error ${response.statusCode}: $message",
        });
      });
    }
  } catch (e) {
    setState(() {
      _messages.add({"role": "assistant", "content": "Exception: $e"});
    });
  } finally {
    setState(() => _loading = false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}


  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.support_agent, color: Color(0xFF0E4839)),
                SizedBox(width: 10),
                Text(
                  'Support Chat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.orange.shade100
                            : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        msg['content'] ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          color: isUser
                              ? Colors.orange.shade900
                              : Colors.green.shade900,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            if (_loading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(color: Color(0xFF0E4839)),
              ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty && !_loading) {
                        sendMessage(value.trim());
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E4839),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _loading || _controller.text.trim().isEmpty
                      ? null
                      : () => sendMessage(_controller.text.trim()),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
