import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> addFeedback(Map<String, double> feedbackData, String userId,
      String jobTitle, double accuracy, double elapsedTime) async {
    final timestamp = DateTime.now().toString();
    try {
      // Add accuracy value to the feedback data
      feedbackData['accuracy'] = accuracy;
      feedbackData['elapsedTime'] = elapsedTime;

      await _firestore
          .collection(jobTitle)
          .doc("userId: $userId timestamp: $timestamp")
          .set(feedbackData);
      return Result(true, "Feedback submitted successfully");
    } catch (e) {
      return Result(false, "Error submitting feedback");
    }
  }

  Future<Map<String, dynamic>> getFeedbackData(
      String jobTitle, String userId) async {
    try {
      // Retrieve documents based on userId field
      QuerySnapshot snapshot = await _firestore
          .collection(jobTitle)
          .where(FieldPath.documentId,
              isGreaterThanOrEqualTo: 'userId: $userId ')
          .where(FieldPath.documentId,
              isLessThanOrEqualTo: 'userId: $userId \uf8ff')
          .get();

      double total = 0.0;
      int count = 0;
      double accuracy = 0.0;
      double elapsedTime = 0.0;
      bool hasData = false;

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        if (doc.id.startsWith("userId: $userId ")) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          accuracy = data['accuracy'] ?? 0.0;
          elapsedTime = data['elapsedTime'] ?? 0.0;
          data.remove('accuracy');
          data.remove('elapsedTime');
          data.forEach((key, value) {
            if (value is double) {
              total += value;
              count++;
            }
          });
          hasData = true;
        }
      }

      if (!hasData) {
        throw Exception("No data found for userId: $userId");
      }

      double averageWorkloadLevel = (total / 60) * count;
      return {
        'workloadLevel': averageWorkloadLevel,
        'accuracy': accuracy,
        'elapsedTime': elapsedTime,
      };
    } catch (e) {
      throw Exception("Error retrieving feedback data: $e");
    }
  }
}

class Result {
  final bool isSuccess;
  final String message;

  Result(this.isSuccess, this.message);
}
