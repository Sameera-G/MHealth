import 'package:flutter/material.dart';
import 'package:nasa_tlx_eeg_research/task1.dart';

class JobTitleInputPage extends StatelessWidget {
  JobTitleInputPage({super.key});

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter User Info'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Your Mental Workload ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: const Text(
                      "Enter the employee ID and most related career path of you. Then a list of questions will be automatically generatd and you have to answer them by selecting the most suitable answer from the list. Your time will be recorded and you have to do within a very short period of time. Then click the floating button at the end. Then in the next page, mark the workload level you experienced. Thank you!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: userIdController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Enter user ID',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: jobTitleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Enter Job Title',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final jobTitle = jobTitleController.text;
                    final userId = userIdController.text;
                    if (jobTitle.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MCQPage(jobTitle: jobTitle, userId: userId),
                        ),
                      );
                    }
                  },
                  child: const Text('Go To Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
