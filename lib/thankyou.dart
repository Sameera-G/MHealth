import 'package:flutter/material.dart';
import 'package:nasa_tlx_eeg_research/wl_level.dart';

class ThankYou extends StatefulWidget {
  final String userId;
  final String jobTitle;
  const ThankYou({super.key, required this.userId, required this.jobTitle});

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workload level',
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //description
            const Text(
              "Mental Workload Level",
              style: TextStyle(
                fontSize: 24.0, // Font size
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold, // Font weight
                //fontStyle: FontStyle.italic, // Font style (italic or normal)
                //decoration: TextDecoration.underline, // Text decoration (underline, line-through, etc.)
                //decorationColor: Colors.red,
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  "Thank you for submitting data",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20.0),

            const SizedBox(height: 20.0), // Add spacing before submit button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedbackScreen(
                            jobTitle: widget.jobTitle,
                            userId: widget.userId,
                          )),
                );
              },
              child: const Text('To see your Mental Workload Level'),
            ),
          ],
        ),
      ),
    );
  }
}
