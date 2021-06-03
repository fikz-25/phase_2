import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phase_1/assets/resources/images.dart';
import 'package:phase_1/model/user_model.dart';
import 'package:phase_1/repositories/user_repository.dart';
import 'package:phase_1/ui/fourthScreen/bloc/fourth_bloc.dart';
import 'package:phase_1/ui/fourthScreen/bloc/fourth_event.dart';
import 'package:phase_1/ui/fourthScreen/bloc/fourth_state.dart';
import 'package:phase_1/ui/secondScreen/second_args.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  late List<Data> _userData = [];
  late FourthBloc _fourthBloc;
  bool primaNumber = true;
  List<bool> tos = [];
  late String _dataUser;

  @override
  void initState() {
    _fourthBloc = FourthBloc(UserRepository());
    _fetchUser();
    super.initState();
  }

  void _fetchUser() {
    _fourthBloc.add(GetAll());
  }

  checkPrime(int n) {
    print(n);
    if (n == 0 || n == 1) {
      primaNumber = false;
    } else {
      for (int i = 2; i <= n / 2; i++) {
        if (n % i == 0) {
          primaNumber = false;
          break;
        }
      }
    }
    _showMessage("id ${n} is Primasi ${primaNumber}");
    return primaNumber;
  }

  setCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dataUser', "${_userData}");
  }

  goToSecondScreen(Data data) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/secondscreen',
        arguments: SecondArguments(data: data));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xfff57e42),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  ImagesItem.IC_BACK_WHITE,
                  width: 15.0,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                "Guest".toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          )),
      body: BlocConsumer<FourthBloc, FourthState>(
        bloc: _fourthBloc,
        listener: (context, state) => {
          if (state is UserLoaded)
            {
              _userData.addAll(state.datas),
              _dataUser = jsonEncode(
                  _userData.map((e) => e.toJson()).toList().toString()),
              setCache()
            }
        },
        builder: (context, state) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: _userData.isEmpty
              ? _isLoading(state)
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(_userData.length, (i) {
                      return InkWell(
                        onTap: () => {
                          checkPrime(_userData[i].id!.toInt()),
                          goToSecondScreen(_userData[i])
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: MediaQuery.of(context).size.width / 8,
                                backgroundImage:
                                    NetworkImage(_userData[i].avatar!),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                  "${_userData[i].firstName!} ${_userData[i].lastName!}"),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _isLoading(state) {
    if (state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container();
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

  Future<void> _onRefresh() async {}
}
