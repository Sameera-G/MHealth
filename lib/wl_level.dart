import 'package:flutter/material.dart';
import 'firebase_services.dart';

class FeedbackScreen extends StatefulWidget {
  final String jobTitle;
  final String userId;

  const FeedbackScreen(
      {super.key, required this.jobTitle, required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late FirebaseServices _firebaseServices;
  double _workloadLevel = 0.0;
  double _accuracy = 0.0;
  double _elapsedTime = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _firebaseServices = FirebaseServices();
    _fetchFeedbackData();
  }

  Future<void> _fetchFeedbackData() async {
    try {
      Map<String, dynamic> data = await _firebaseServices.getFeedbackData(
          widget.jobTitle, widget.userId);
      if (mounted) {
        setState(() {
          _workloadLevel = data['workloadLevel'];
          _accuracy = data['accuracy'];
          _elapsedTime = data['elapsedTime'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error retrieving data: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Data"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.black
                            .withOpacity(0.5), // Set transparency to 50%
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth,
                            child: const Center(
                              child: Text(
                                "Your workload level is as follows, HR will contact you for further proceedings!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        color: Colors.black
                            .withOpacity(0.5), // Set transparency to 50%
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth,
                            child: Center(
                              child: Text(
                                "Job Title: ${widget.jobTitle}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        color: Colors.black
                            .withOpacity(0.5), // Set transparency to 50%
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth,
                            child: Center(
                              child: Text(
                                "User ID: ${widget.userId}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        color: Colors.black
                            .withOpacity(0.5), // Set transparency to 50%
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Workload Level: $_workloadLevel",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        color: Colors.black
                            .withOpacity(0.5), // Set transparency to 50%
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Accuracy Percentage: $_accuracy%",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        color: Colors.black
                            .withOpacity(0.5), // Set transparency to 50%
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth,
                            child: Text(
                              "Elapsed Time: $_elapsedTime seconds",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: FeedbackScreen(jobTitle: "yourJobTitle", userId: "yourUserId"),
  ));
}
