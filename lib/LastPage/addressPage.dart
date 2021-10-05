import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Theme.dart';

class AddressPage extends StatefulWidget {
  final bool whereToSend;
  double? latitude;
  double? longitude;

  AddressPage({this.whereToSend = false, this.latitude, this.longitude});
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final addressName = TextEditingController();

  final city = TextEditingController();

  final country = TextEditingController();

  final address1 = TextEditingController();

  final block = TextEditingController();

  final building = TextEditingController();

  final street = TextEditingController();

  final flat = TextEditingController();

  final paciNumber = TextEditingController();

  var custID;
  bool _isLoading = false;

  List<StateData> stateList = [];
  List<DropdownMenuItem> menuItems = [];
  int _value = 0;

  List cityList = [];
  List<DropdownMenuItem> cityListItems = [];
  int _cityValue = 0;

  Completer<GoogleMapController> _controller = Completer();

  double lat = 0;
  double long = 0;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    getStateList();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Page'),
        centerTitle: true,
        backgroundColor: Style.prime[900],
        titleTextStyle: Style.subtitle.copyWith(
          fontSize: 16,
          color: Style.white.withOpacity(0.87),
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text('AddressController'),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 20),
              //   child: Text('enter_address'.tr,
              //       style: Style.subtitle.copyWith(
              //         fontSize: 16,
              //         color: Style.accent,
              //       )),
              // ),

              SizedBox(
                height: 20,
              ),
              textFields(label: 'address_name'.tr, controller: addressName),
              SizedBox(
                height: 20,
              ),
              textFields(label: 'Country'.tr, controller: country),
              SizedBox(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 0.8),
                  color: Style.prime[50]!.withOpacity(0.08),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  // borderSide: BorderSide(
                  //   width: 1,
                  // ),
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                      focusColor: Style.accent[50],
                      hint: Text(
                        'your_state'.tr,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // disabledHint: Text(''),
                      value: _value,
                      items: (stateList.isEmpty) ? [] : menuItems,
                      onChanged: (value) {
                        setState(
                          () {
                            _value = value!;
                            _cityValue = 0;
                          },
                        );
                        getCityList();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 0.8),
                  color: Style.prime[50]!.withOpacity(0.08),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  // borderSide: BorderSide(
                  //   width: 1,
                  // ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                      focusColor: Style.prime[50]!.withOpacity(0.60),
                      hint: Text(
                        'your_city'.tr,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // disabledHint: Text(''),
                      value: _cityValue,
                      items: (cityListItems.isEmpty) ? [] : cityListItems,
                      onChanged: (value) {
                        setState(
                          () {
                            _cityValue = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              textFields(label: 'address_one'.tr, controller: address1),
              SizedBox(
                height: 25,
              ),
              textFields(label: 'paci_number'.tr, controller: paciNumber),
              SizedBox(
                height: 25,
              ),
              textFields(label: 'block'.tr, controller: block),
              SizedBox(
                height: 25,
              ),
              textFields(label: 'building'.tr, controller: building),
              SizedBox(
                height: 25,
              ),
              textFields(label: 'street'.tr, controller: street),
              SizedBox(
                height: 25,
              ),
              textFields(label: 'flat'.tr, controller: flat),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getLocation(),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        Scaffold(
                          body: Container(
                            child: GoogleMap(
                              markers: _markers,
                              onTap: (latlong) {
                                print(latlong.latitude);
                                print(latlong.longitude);
                                setState(() {
                                  lat = latlong.latitude;
                                  long = latlong.longitude;
                                });

                                Get.defaultDialog(
                                  title: 'recorded'.tr,
                                  middleText:
                                      'Your LatLang is: ${lat.toStringAsFixed(2)} and ${long.toStringAsFixed(2)} ',
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          // Get.back(AddressPage());
                                          setState(
                                            () {
                                              widget.latitude = lat;
                                              widget.longitude = long;
                                            },
                                          );
                                          Get.close(2);
                                        },
                                        child: Text("confirm".tr))
                                  ],
                                );
                              },
                              mapType: MapType.normal,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(29.3117, 47.4818), zoom: 10),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: Get.height / 16,
                      width: Get.width / 4,
                      decoration: BoxDecoration(
                        color: Style.accent[500],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        (widget.longitude == null || widget.latitude == null)
                            ? Icons.location_searching_outlined
                            : Icons.check,
                        color: Style.white.withOpacity(0.87),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Style.prime[700]),
                      foregroundColor: MaterialStateProperty.all(
                          Style.white.withOpacity(0.87)),
                      elevation: MaterialStateProperty.all(8),
                      shadowColor: MaterialStateProperty.all(Style.accent[50]),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                    ),
                    onPressed: () {
                      apiPostRequest(context);
                    },
                    child: Text(
                      'Add Address'.tr,
                      style: Style.subtitle.copyWith(
                        fontSize: 18,
                        color: Style.white.withOpacity(0.82),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFields({String label = '', TextEditingController? controller}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: Get.height / 15,
      child: TextFormField(
        controller: controller,
        cursorColor: Style.accent[500],
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: Style.accent[600],
          letterSpacing: 0.4,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        decoration: Style.inputTextDecoration(
          title: label,
        ),
        // decoration: InputDecoration(
        //   isDense: true,
        //   filled: true,
        //   fillColor: Style.accent[50]!.withOpacity(0.087),
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(4)),
        //     borderSide: BorderSide(
        //       width: 1,
        //     ),
        //   ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(4)),
        //     borderSide: BorderSide(width: 0.8, color: Style.accent[50]!),
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(4)),
        //     borderSide: BorderSide(width: 0.8, color: Style.prime[500]!),
        //   ),
        //   labelText: label,
        //   labelStyle: Style.subtitle.copyWith(
        //     fontSize: 14,
        //     color: Style.accent[100],
        //   ),
        //   floatingLabelStyle: Style.subtitle.copyWith(
        //     color: Style.prime[900],
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
      ),
    );
  }

  Future getStateList() async {
    var response = await http
        .post(Uri.parse('https://foodapi.pos53.com/api/Food/DeliveryStateGet'));

    List<StateData> statesToAdd = [];
    List<DropdownMenuItem> itemList = [];

    if (response.statusCode <= 299) {
      var body = jsonDecode(response.body)['data'];
      int index = 0;
      for (var state in body) {
        var newState =
            StateData(state['StateName'] as String, state['StateID']);
        statesToAdd.add(newState);
        itemList.add(DropdownMenuItem(
          child: Text(
            state['StateName'] as String,
            style: TextStyle(color: Style.accent),
          ),
          value: index,
        ));
        index++;
      }
    }

    setState(() {
      if (statesToAdd.isNotEmpty) {
        stateList.addAll(statesToAdd);
        menuItems.addAll(itemList);
      }
    });
    getCityList();
  }

  Future<void> getCityList() async {
    var stateId = stateList[_value].stateId;
    var cities = [];
    List<DropdownMenuItem> cityItems = [];
    var response = await http.post(
        Uri.parse('https://foodapi.pos53.com/api/Food/DeliveryCityGet'),
        body: {'StateID': stateId.toString()});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body['data']);
      int i = 0;
      for (var city in body['data']) {
        cities.add(city['CityEnglish']);
        cityItems.add(DropdownMenuItem(
          child: Text(
            city['CityEnglish'],
            style: TextStyle(color: Style.accent),
          ),
          value: i,
        ));
        i++;
        print(city);
      }
    }

    setState(() {
      if (cities.isNotEmpty) {
        if (cityList.isNotEmpty) {
          cityList.clear();
          cityListItems.clear();
        }
        cityList.addAll(cities);
        cityListItems.addAll(cityItems);
      }
    });
    print(cityList);
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        widget.latitude = position.latitude;
        widget.longitude = position.longitude;
      });
      print('latitude: ${widget.latitude} and longitude: ${widget.longitude}');
    } catch (e) {
      print(e);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      custID = prefs.get('custID');
    });
    print('custID: $custID');
  }

  void apiPostRequest(BuildContext context) async {
    if (addressName.text.isEmpty ||
        country.text.isEmpty ||
        cityList.isEmpty ||
        address1.text.isEmpty ||
        block.text.isEmpty ||
        building.text.isEmpty ||
        street.text.isEmpty ||
        flat.text.isEmpty ||
        paciNumber.text.isEmpty ||
        widget.latitude == null ||
        widget.longitude == null ||
        custID == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'error'.tr,
              style: TextStyle(fontSize: 30, color: Style.accent),
            )),
            content: Text(
              'fill_all'.tr,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            actions: [
              TextButton(
                child: Text(
                  'ok'.tr,
                  style: TextStyle(fontSize: 20, color: Style.accent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> body = {
        'TenentID': TenentID.toString(),
        'GoogleName': addressName.text,
        'CITY': cityList[_cityValue],
        'STATE': stateList[_value].stateName,
        'COUNTRYID': 114.toString(),
        'Action': 'ADD',
        'CUSERID': custID.toString(),
        'AdressName1': address1.text,
        'PACKNumber': paciNumber.text,
        'Block': block.text,
        'Building': building.text,
        'Street': street.text,
        'ForFlat': flat.text,
        'Longitute': widget.longitude.toString(),
        'Latitute': widget.latitude.toString()
      };

      var response = await http.post(
          Uri.parse('https://foodapi.pos53.com/api/Food/DeliveryAddressSave'),
          body: body);
      print('The response is ${response.body}');
      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'error'.tr,
                  style: Style.subtitle.copyWith(
                    fontSize: 18,
                    letterSpacing: 0.8,
                    color: Style.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Text(
                'problem_occured'.tr,
                style: Style.subtitle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Style.accent[300],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'ok'.tr,
                    style: TextStyle(fontSize: 20, color: Style.accent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _getLocation() {
    return GestureDetector(
      onTap: getCurrentLocation,
      child: Container(
        height: Get.height / 16,
        width: Get.width / 4,
        decoration: BoxDecoration(
          color: Style.prime[500],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          (widget.longitude == null || widget.latitude == null)
              ? Icons.location_pin
              : Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}

class StateData {
  String stateName;
  int stateId;

  StateData(this.stateName, this.stateId);

  @override
  String toString() {
    return 'stateName: $stateName, stateId: $stateId';
  }
}
