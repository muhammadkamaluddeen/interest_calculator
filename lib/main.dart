import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Simple Interest Calculator",
      home: SIForm(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var _displayText1 ="";
  var _displayText2 = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Simple Interest Calculator",
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
        padding: EdgeInsets.all(20.0),
        //padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(.0),
                child: getImageAsset(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Principal',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(fontSize: 20, color: Colors.yellow),
                  hintText: 'Enter Principal eg 1200',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
           controller: principalController,
             validator: (String value){
                if(value.isEmpty) {
                  // ignore: missing_return, missing_return
                  return 'Principal cannot be Empty!';
                }
             },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Rate',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(fontSize: 20,color: Colors.yellow),
                  hintText: 'Enter Rate',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
                controller: rateController,
              validator: (String value){
                if(value.isEmpty) {
                  return 'Rate cannot be Empty!';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Time',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(fontSize: 20, color:Colors.yellow),
                  hintText: 'Enter Time',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
                    controller: timeController,
              validator: (String value){
                if(value.isEmpty) {
                  // ignore: missing_return, missing_return
                  return 'Time cannot be Empty!';
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.indigoAccent)),
                    onPressed: () {
                      setState(() {
                        if(_formKey.currentState.validate()) {
                          _calcAmount();
                          _calcInterest();
                          interestDialog();
                        }
                      });
                    },
                    child: Text("Calculate", style: textStyle),
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigoAccent)),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                    child: Text("Reset", style: textStyle),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),


          ],
        ),
      ),),
    );
  }

  //Function to calculate Total Amount
  String _calcInterest(){
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    int time = int.parse(timeController.text);

    double amount1 =  (principal * rate * time)/100;
    String result1 = "Interest is: $amount1";
    _displayText1 = result1;
    return _displayText1;
  }



  //Function to calculate Interest
  String _calcAmount(){
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    int time = int.parse(timeController.text);

    double amount2 = principal + (principal * rate * time)/100;
    String result2 = "Total Amount: $amount2";
    _displayText2 = result2;
    return _displayText2;
  }


  void interestDialog(){
    var alertDialog = AlertDialog(
      title: Text("Result",style: TextStyle(fontSize: 25)),
      content: Text("$_displayText1 \n \n$_displayText2", style: TextStyle(fontSize: 25)) ,
      backgroundColor: Colors.indigoAccent,
    );
    showDialog(context: context, builder:(BuildContext context){
      return alertDialog;
    });
  }

  void _reset(){
    principalController.text ='';
    timeController.text ='';
    rateController.text = '';
    _displayText2 ='';
    _displayText1 ='';

  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/naira-removebg-preview.png');
  Image image = Image(image: assetImage, width: 170.0, height: 170.0);

  return Container(
    child: image,
  );

}


