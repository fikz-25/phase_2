import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phase_1/assets/resources/images.dart';
import 'package:phase_1/model/event_model.dart';
import 'package:phase_1/ui/fifthScreen/fifth_args.dart';

class FifthScreen extends StatefulWidget {
  @override
  _FifthScreenState createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  FifthArguments? args;
  int? selectedEvent;
  late BitmapDescriptor selectMarker;
  late BitmapDescriptor marker;
  Completer<GoogleMapController> _controller = Completer();
  final dateFormat = new DateFormat('dd-MM-yyyy');

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.782991, 110.367027),
    zoom: 17.0,
  );

  List<Marker> _marker() {
    List<Marker> datas = [];
    setState(() {
      for (var i = 0; i < args!.event!.length; i++) {
        datas.add(Marker(
            markerId: MarkerId(args!.event![i].id.toString()),
            draggable: false,
            icon: args!.event![i].id == selectedEvent ? selectMarker : marker,
            position: LatLng(args!.event![i].latitude!.toDouble(),
                args!.event![i].longitude!.toDouble())));
      }
    });
    return datas;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      selectMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(55, 55)),
          ImagesItem.IC_MARKER_SELECTED);

      marker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(55, 55)), ImagesItem.IC_MARKER);

      setState(() {});
    });
    super.initState();
  }

  updateCamera(int i, double latitude, double longitude) async {
    CameraPosition cPosition = CameraPosition(
      zoom: 17.0,
      target: LatLng(latitude, longitude),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      selectedEvent = i;
      print(selectedEvent.toString());
      _marker();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      args = ModalRoute.of(context)!.settings.arguments as FifthArguments;
      selectedEvent = args?.event![0].id!.toInt();
    }
    return Scaffold(
        body: SafeArea(
      child: args!.event!.isEmpty
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(_marker()),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  height: MediaQuery.of(context).size.height / 5,
                  child: ListView.builder(
                      itemCount: args!.event!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () => updateCamera(
                              args!.event![index].id!,
                              args!.event![index].latitude!,
                              args!.event![index].longitude!),
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 20.0 : 10, right: 10.0),
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
                                            args!.event![index].image!,
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
                                                args!.event![index].name!,
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
                                                args!.event![index].name!,
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
                                              args!.event![index].date!)),
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
                              )))),
                )
              ],
            ),
    ));
  }
}
