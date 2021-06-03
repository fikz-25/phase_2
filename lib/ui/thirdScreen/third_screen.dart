import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phase_1/assets/resources/images.dart';
import 'package:phase_1/model/event_model.dart';
import 'package:phase_1/repositories/event_repository.dart';
import 'package:phase_1/ui/fifthScreen/fifth_args.dart';
import 'package:phase_1/ui/secondScreen/second_args.dart';
import 'package:phase_1/ui/thirdScreen/bloc/third_bloc.dart';
import 'package:phase_1/ui/thirdScreen/bloc/third_event.dart';
import 'package:phase_1/ui/thirdScreen/bloc/third_state.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late List<Event> _evetData = [];
  late ThirdBloc _thirdBloc;
  final dateFormat = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    _thirdBloc = ThirdBloc(EventRepository());
    _fetchEvent();
    super.initState();
  }

  void _fetchEvent() {
    _thirdBloc.add(GetEvent());
  }

  goToSecondScreen(Event event) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/secondscreen',
        arguments: SecondArguments(event: event));
  }

  goToFifthScreen() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/fifthscreen',
        arguments: FifthArguments(event: _evetData));
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                  "Events".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    ImagesItem.IC_SEARCH_WHITE,
                    width: 25.0,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () => goToFifthScreen(),
                  child: Image.asset(
                    ImagesItem.IC_MAO_VIEW,
                    width: 25.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: BlocConsumer<ThirdBloc, ThirdState>(
        bloc: _thirdBloc,
        listener: (context, state) => {
          if (state is EventLoaded) {_evetData.addAll(state.events)}
        },
        builder: (context, state) => _evetData.isEmpty
            ? _isLoading(state)
            : Container(
                child: ListView.builder(
                    itemCount: _evetData.length,
                    itemBuilder: (context, i) => InkWell(
                          onTap: () => goToSecondScreen(_evetData[i]),
                          child: Container(
                              margin: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 8.0,
                                top: i == 0 ? 30.0 : 8.0,
                              ),
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: (Radius.circular(10.0)),
                                            bottomLeft:
                                                (Radius.circular(10.0))),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            _evetData[i].image!,
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.7,
                                              child: Text(
                                                _evetData[i].name!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.7,
                                              child: Text(
                                                _evetData[i].name!,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 10.0, bottom: 10.0),
                                        child: Text(
                                          dateFormat.format(DateTime.parse(
                                              _evetData[i].date!)),
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        )),
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
}
