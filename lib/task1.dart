// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_tlx_eeg_research/slider_form.dart';
import 'dart:async';

class MCQPage extends StatefulWidget {
  final String jobTitle;
  final String userId;

  const MCQPage({required this.jobTitle, required this.userId, super.key});

  @override
  MCQPageState createState() => MCQPageState();
}

class MCQPageState extends State<MCQPage> {
  final String apiKey =
      'sk-proj-trcWeVqBNH5gLqUd9DUnT3BlbkFJPQRrBuRk4Dovo3PFCI78';
  List<MCQ> questions = [];
  Map<int, String> selectedAnswers = {};
  bool isLoading = false;

  late Stopwatch stopwatch;
  late String formattedTime = '';
  late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchMCQs(widget.jobTitle);
    stopwatch = Stopwatch();
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        formattedTime = _formatTime(stopwatch.elapsed);
      });
    });
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> fetchMCQs(String jobTitle) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-4o',
          'messages': [
            {
              'role': 'user',
              'content':
                  'Generate 20 MCQ questions related to the tasks of a $jobTitle. Each question should have 4 options with one correct answer.'
            }
          ],
          'max_tokens': 2000,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final text = data['choices'][0]['message']['content'] as String;
        print('Generated text:\n$text'); // Debug: print the generated text
        final parsedQuestions = parseQuestions(text);
        setState(() {
          questions = parsedQuestions;
          stopwatch.start();
        });
        print('Questions set in state: ${questions.length}');
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error']['message'];
        print('Failed to load questions: $errorMessage');
        throw Exception('Failed to load questions: $errorMessage');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<MCQ> parseQuestions(String text) {
    final List<MCQ> mcqs = [];
    final lines =
        text.split('\n').where((line) => line.trim().isNotEmpty).toList();

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith(RegExp(r'\d+\.'))) {
        final questionIndex = lines[i].indexOf('.');
        final question = lines[i].substring(questionIndex + 1).trim();
        final options = <String>[];
        String correctAnswer = '';

        for (int j = 1; j <= 4; j++) {
          final optionIndex = lines[i + j].indexOf('.');
          final option = lines[i + j].substring(optionIndex + 1).trim();
          options.add(option);
        }

        final answerIndex = lines[i + 4].indexOf('.');
        correctAnswer = lines[i + 4].substring(answerIndex + 1).trim();

        mcqs.add(MCQ(question, options, correctAnswer));
      }
    }

    return mcqs;
  }

  void calculateAccuracy() {
    print('Calculate Accuracy function called');
    int correctAnswers = 0;
    for (var i = 0; i < questions.length; i++) {
      print('Question: ${questions[i].question}'); // Debug: print question
      print(
          'Selected answer: ${selectedAnswers[i]}'); // Debug: print selected answer
      print(
          'Correct answer: ${questions[i].correctAnswer}'); // Debug: print correct answer

      // Check if the selected answer matches the correct answer
      if (selectedAnswers.containsKey(i) &&
          selectedAnswers[i] == questions[i].correctAnswer) {
        correctAnswers++;
      }
    }
    final accuracy = (correctAnswers / questions.length) * 100;
    print('Accuracy calculated: $accuracy');
    stopwatch.stop();
    final elapsedTime = stopwatch.elapsed.inSeconds;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Accuracy'),
          content: Text('Your accuracy is ${accuracy.toStringAsFixed(2)}%'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SliderFormPage(
                      userId: widget.userId,
                      jobTitle: widget.jobTitle,
                      accuracy: accuracy,
                      elapsedTime: elapsedTime,
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('isLoading: $isLoading');
    print('questions length: ${questions.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCQ Job Task App'),
        // Add this line
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Elapsed Time: $formattedTime',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ), // A
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : questions.isEmpty
                ? const Center(child: Text('No questions found'))
                : ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Q${index + 1}: ${questions[index].question}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ...questions[index]
                                  .options
                                  .asMap()
                                  .entries
                                  .map((option) {
                                return RadioListTile<String>(
                                  title: Text(option.value),
                                  value: option.value,
                                  groupValue: selectedAnswers[index],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers[index] = value!;
                                    });
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => calculateAccuracy(),
        child: const Icon(Icons.check),
      ),
    );
  }
}

class MCQ {
  final String question;
  final List<String> options;
  final String correctAnswer;

  MCQ(this.question, this.options, this.correctAnswer);
}
