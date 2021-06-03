import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phase_1/assets/resources/images.dart';
import 'package:phase_1/ui/secondScreen/second_args.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  SecondArguments? args;
  String? nameEvent = '';
  String? nameGuest = '';
  int? id = 0;

  @override
  void initState() {
    super.initState();
  }

  goToThirdScreen() {
    Navigator.pushNamed(context, '/thirdscreen');
  }

  goToFourtdScreen() {
    Navigator.pushNamed(context, '/fourthscreen');
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      args = ModalRoute.of(context)!.settings.arguments as SecondArguments;
      if (args?.event != null) {
        nameEvent = args?.event?.name!;
      } else if (args?.data != null) {
        nameGuest = "${args?.data?.firstName!} ${args?.data?.lastName!}";
        id = args?.data?.id!.toInt();
        setState(() {
          if (id! % 2 == 0 && id! % 3 == 0) {
            _showMessage("iOs");
          } else if (id! % 2 == 0) {
            _showMessage("android");
          } else if (id! % 3 == 0) {
            _showMessage("blackberry");
          } else {
            _showMessage("feature phones");
          }
        });
      } else {
        // ignore: unnecessary_statements
        null;
      }
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image.asset(
                      ImagesItem.BG_BRIGHT,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 14),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hallo",
                                      style: TextStyle(
                                          color: Color(0xff4f4f4f),
                                          fontSize: 30.0),
                                    ),
                                    Text(
                                      "Arman",
                                      style: TextStyle(
                                          color: Color(0xfff57e42),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 7,
                          ),
                          InkWell(
                            onTap: () => goToThirdScreen(),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Color(0xfff57e42),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    nameEvent != ''
                                        ? nameEvent!
                                        : "Choose Event",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            onTap: () => goToFourtdScreen(),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Color(0xfff57e42),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    nameGuest != ''
                                        ? nameGuest!
                                        : "Choose Guest",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    ImagesItem.IMG_SUITEMEDIA,
                    width: MediaQuery.of(context).size.width / 1.4,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Image.asset(
                    ImagesItem.IMG_BG_BOTTOM,
                    fit: BoxFit.fitWidth,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
