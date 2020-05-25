import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizBrain.dart';
QuizBrain quizbrain=QuizBrain();
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Quizpage(),
        ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}
class _QuizpageState extends State<Quizpage> {
  List<Icon> listname=[];
  int correct=0,wrong=0;
  void checkans(bool ans){
    bool correctans=quizbrain.getcorrectans();
    setState(() {
      if(quizbrain.isfinished()==true){
        double percentile=correct/(correct+wrong);
        Alert(
            context: context,
            title: 'Finished',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();

        if(percentile>=0.75){
          Alert(
              context:context,
              title:'Congrats',
              desc:'Your Score is $percentile'
          ).show();
        }
        else{
          Alert(
              context:context,
              title:'Sorry,Better Luck Next Time!!',
              desc:'Your Score is $percentile'
          ).show();
        }
          quizbrain.reset();
          listname=[];
          wrong=0;correct=0;
        }

      else{
        if(correctans==ans){
          correct++;
          listname.add(Icon(Icons.check,color:Colors.green));
        }
        else{
          wrong++;
          listname.add(Icon(Icons.close,color:Colors.red));
        }
        quizbrain.nextQuestion();}
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding:EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white
                  ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  fontSize:20.0,
                  color: Colors.white,
                )
              ),
              onPressed: (){
                checkans(true);
              },
            )
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.red,
                child: Text(
                    'False',
                    style: TextStyle(
                      fontSize:20.0,
                      color: Colors.white,
                    )
                ),
                onPressed: (){
                  checkans(false);
                },
              ),
          ),
        ),
        Row(
          children:listname,
        )
      ],
    );
  }
}

