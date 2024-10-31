import 'package:flutter/material.dart';
import 'package:nasa_tlx_eeg_research/jobtitle.dart';
import 'package:nasa_tlx_eeg_research/thankyou.dart';
import 'firebase_services.dart';

class SliderFormPage extends StatefulWidget {
  final String userId;
  final String jobTitle;
  final double accuracy;
  final int elapsedTime;

  const SliderFormPage({
    super.key,
    required this.userId,
    required this.jobTitle,
    required this.accuracy,
    required this.elapsedTime,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SliderFormPageState createState() => _SliderFormPageState();
}

class _SliderFormPageState extends State<SliderFormPage> {
  final Map<String, double> _sliderValues = {
    'Mental Demand - How mentally demanding was the task?': 0.0,
    'Physical Demand - How physically demanding was the task?': 0.0,
    'Temporal Demand - How hurried or rushed was the pace of the task?': 0.0,
    'Performance - How successful were you in accomplishing what you were asked to do?':
        0.0,
    'Effort - How hard did you have to work to accomplish your level of performance?':
        0.0,
    'Frustration - How insecure, discouraged, irritated, stressed, and annoyed were you?':
        0.0,
  };

  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workload Levels - NASA_TLX',
            style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "NASA Task Load Index",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                    child: Text(
                  "Hart and Staveland’s NASA Task Load Index (TLX) method, assesses work load on six 7-point scales. Increments of high, medium and low estimates, for each point result in 21 gradations on the scales.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
              const Divider(),
              const SizedBox(height: 20.0),
              _buildSliderRow(
                  'Mental Demand - How mentally demanding was the task?'),
              _buildSliderRow(
                  'Physical Demand - How physically demanding was the task?'),
              _buildSliderRow(
                  'Temporal Demand - How hurried or rushed was the pace of the task?'),
              _buildSliderRow(
                  'Performance - How successful were you in accomplishing what you were asked to do?'),
              _buildSliderRow(
                  'Effort - How hard did you have to work to accomplish your level of performance?'),
              _buildSliderRow(
                  'Frustration - How insecure, discouraged, irritated, stressed, and annoyed were you?'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _firebaseServices.addFeedback(
                        _sliderValues,
                        widget.userId,
                        widget.jobTitle,
                        widget.accuracy,
                        widget.elapsedTime.toDouble());
                    _showSnackBar(
                        "Feedback submitted successfully!", Colors.green);
                    _navigateToThankYouPage();
                  } catch (e) {
                    _showSnackBar("Error submitting feedback: $e", Colors.red);
                  }
                },
                child: const Text('Submit Results'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JobTitleInputPage()),
                  );
                },
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToThankYouPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ThankYou(jobTitle: widget.jobTitle, userId: widget.userId)));
  }

  void _showSnackBar(String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildSliderRow(String title) {
    final value = _sliderValues[title]!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              title,
              softWrap: true,
              maxLines: 4, // Limits the number of lines to 2 (optional)
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10.0),
            Expanded(
              child: Slider(
                value: value,
                min: 0.0,
                max: 10.0,
                divisions: 10,
                label: value.round().toString(),
                onChanged: (double newValue) {
                  setState(() {
                    _sliderValues[title] = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
