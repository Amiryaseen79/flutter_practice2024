import 'package:flutter/material.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int score = 0;
  bool isQuizStarted = false;
  int timer = 25;
  bool isTimeout = false;
  bool isQuizFinished = false;

  // Cancel flag for timer
  bool shouldCancelTimer = false;

  // Function to check the answer and update the state
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (!isTimeout && correctAnswer == userPickedAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        score++;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }

      // Check if quiz is finished
      if (quizBrain.isFinished()) {
        isQuizFinished = true;
        shouldCancelTimer = true; // Stop the timer
        showResult();
      } else {
        quizBrain.nextQuestion();
        resetTimer();
      }
    });
  }

  // Function to start the quiz
  void startQuiz() {
    setState(() {
      isQuizStarted = true;
      shouldCancelTimer = false; // Reset cancel flag
      resetTimer();
    });
  }

  // Function to reset the timer
  void resetTimer() {
    setState(() {
      timer = 25;
      isTimeout = false;
      startTimer();
    });
  }

  // Function to start the countdown timer
  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && !shouldCancelTimer) {
        setState(() {
          if (timer > 0) {
            timer--;
            startTimer();
          } else {
            isTimeout = true;
            checkAnswer(false); // Timeout counts as an incorrect answer
          }
        });
      }
    });
  }

  // Function to show the result dialog
  void showResult() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents the dialog from being dismissed without pressing the button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quiz Completed!"),
          content: Text("Your score is $score/${quizBrain.getTotalQuestions()}"),
          actions: [
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                resetQuiz(); // Reset the quiz
              },
            ),
          ],
        );
      },
    );
  }

  // Function to reset the quiz state
  void resetQuiz() {
    setState(() {
      quizBrain.reset();
      scoreKeeper.clear();
      score = 0;
      timer = 25;
      isQuizStarted = false;
      isQuizFinished = false;
      isTimeout = false;
      shouldCancelTimer = true; // Stop any ongoing timer before restarting
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: isQuizStarted
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Time Left: $timer seconds',
              style: TextStyle(fontSize: 20.0),
            ),
            Expanded(
              child: Center(
                child: Text(
                  quizBrain.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            checkAnswer(true);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            primary: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.green],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('True'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            checkAnswer(false);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            primary: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.orange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('False'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: scoreKeeper,
            ),
          ],
        )
            : Center(
          child: Container(
            width: 220, // Adjusted width for a circular look
            height: 220, // Adjusted height for a circular look
            child: ElevatedButton(
              onPressed: startQuiz,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Colors.transparent,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Start Quiz',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Quiz question model
class Question {
  String questionText;
  bool questionAnswer;

  Question(this.questionText, this.questionAnswer);
}

// Quiz logic and state management
class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('The earth is flat.', false),
    Question('The sun rises in the east.', true),
    Question('There are seven continents in the world.', true),
    Question('Python is a type of snake.', true),
    Question('Flutter is used for mobile app development.', true),
    Question('Humans can breathe underwater without assistance.', false),
    Question('Birds are mammals.', false),
    Question('Water boils at 100 degrees Celsius.', true),
    Question('Humans have three lungs.', false),
    Question('The capital of France is Berlin.', false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }

  int getTotalQuestions() {
    return _questionBank.length;
  }
}
