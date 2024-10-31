/*
import 'package:flutter/material.dart';
import 'package:nasa_tlx_eeg_research/slider_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userIdController = TextEditingController();
  String _selectedJob = ''; // Store selected job

  void _navigateToSliderForm(String userId, String jobTitle) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SliderFormPage(userId: userId, jobTitle: jobTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Feedback of Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  "After each task in Treplicator, Enter your user ID in the field below and tell us what you think about that task.",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.white54),
                    hintText: 'Enter User ID',
                    fillColor: Colors.white54,
                  ),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedJob = 'Software Engineering';
                    });
                    if (_userIdController.text.isNotEmpty &&
                        _selectedJob.isNotEmpty) {
                      _navigateToSliderForm(
                          _userIdController.text, _selectedJob);
                    } else {
                      _showErrorSnackBar(
                          "Enter the user identification number");
                    }
                  },
                  child: const SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: Center(
                      child: Text('Software Engineer'),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedJob = 'Health Services';
                    });
                    if (_userIdController.text.isNotEmpty &&
                        _selectedJob.isNotEmpty) {
                      _navigateToSliderForm(
                          _userIdController.text, _selectedJob);
                    } else {
                      _showErrorSnackBar(
                          "Enter the user identification number");
                    }
                  },
                  child: const SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: Center(
                      child: Text('Health Services'),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedJob = 'Teaching';
                    });
                    if (_userIdController.text.isNotEmpty &&
                        _selectedJob.isNotEmpty) {
                      _navigateToSliderForm(
                          _userIdController.text, _selectedJob);
                    } else {
                      _showErrorSnackBar(
                          "Enter the user identification number");
                    }
                  },
                  child: const SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: Center(
                      child: Text('Teaching'),
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

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
*/
