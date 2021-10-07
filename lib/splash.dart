import 'package:baguard_full/main.dart';
import 'package:flutter/material.dart';
import 'package:baguard_full/body/back_ground_image.dart';

class Splase extends StatefulWidget {
  const Splase({Key? key}) : super(key: key);

  @override
  _SplaseState createState() => _SplaseState();
}

class _SplaseState extends State<Splase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/icon/himalaya_bag.png'),
      )),
      child: Container(
        margin: EdgeInsets.all(30),
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
