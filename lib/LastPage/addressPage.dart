import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme.dart';

class AddressPage extends StatelessWidget {
  final addressName = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final address1 = TextEditingController();
  final block = TextEditingController();
  final building = TextEditingController();
  final street = TextEditingController();
  final flat = TextEditingController();
  final paciNumber = TextEditingController();

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
                    borderRadius: BorderRadius.circular(25),
                    color: Style.accent),
                // child: DropdownButtonHideUnderline(
                //   child: DropdownButton(
                //     focusColor: Style.accent[50],
                //     hint: Text('your_state'.tr),
                //     // value: _value,
                //     // items: (stateList.isEmpty) ? [] : menuItems,
                //     // onChanged: (value) {
                //     //   setState(() {
                //     //     _value = value;
                //     //     _cityValue = 0;
                //     //   });
                //     //   getCityList();
                //     },
                //   ),
                // ),
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
                  borderRadius: BorderRadius.circular(25),
                  color: Style.prime,
                ),
                // child: DropdownButtonHideUnderline(
                //   child: DropdownButton(
                //     focusColor: BeHealthyTheme.kMainOrange,
                //     hint: Text('your_city'.tr),
                //     value: _cityValue,
                //     items: (cityListItems.isEmpty) ? [] : cityListItems,
                //     onChanged: (value) {
                //       setState(() {
                //         _cityValue = value;
                //       });
                //     },
                //   ),
                // ),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // _getLocation(),
              //     GestureDetector(
              //       onTap: () {
              //         Get.dialog(
              //           Scaffold(
              //             body: Container(
              //                 // child: GoogleMap(
              //                 //   markers: _markers,
              //                 //   onTap: (latlong) {
              //                 //     print(latlong.latitude);
              //                 //     print(latlong.longitude);
              //                 //     setState(() {
              //                 //       lat = latlong.latitude;
              //                 //       long = latlong.longitude;
              //                 //     });

              //                 //     Get.defaultDialog(
              //                 //         title: 'recorded'.tr,
              //                 //         middleText:
              //                 //             'Your LatLang is: ${lat.toStringAsFixed(2)} and ${long.toStringAsFixed(2)} ',
              //                 //         actions: [
              //                 //           ElevatedButton(
              //                 //               onPressed: () {
              //                 //                 // Get.back(AddressPage());
              //                 //                 setState(() {
              //                 //                   widget.latitude = lat;
              //                 //                   widget.longitude = long;
              //                 //                 });
              //                 //                 Get.close(2);
              //                 //               },
              //                 //               child: Text("confirm".tr))
              //                 //         ]);
              //                 //   },
              //                 //   mapType: MapType.normal,
              //                 //   onMapCreated: (GoogleMapController controller) {
              //                 //     _controller.complete(controller);
              //                 //   },
              //                 //   initialCameraPosition: CameraPosition(
              //                 //       target: LatLng(29.3117, 47.4818), zoom: 10),
              //                 // ),

              //                 ),
              //           ),
              //         );
              //       },
              //       // child: Container(
              //       //   height: MediaQuery.of(context).size.height / 18,
              //       //   width: MediaQuery.of(context).size.width / 4,
              //       //   decoration: BoxDecoration(
              //       //       color: BeHealthyTheme.kMainOrange,
              //       //       borderRadius: BorderRadius.circular(20)),
              //       //   child: Icon(
              //       //     (widget.longitude == null || widget.latitude == null)
              //       //         ? Icons.map
              //       //         : Icons.check,
              //       //     color: Colors.white,
              //       //   ),
              //       // ),
              //     ),
              //   ],
              // ),

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
                          MaterialStateProperty.all(Style.prime[900]),
                      foregroundColor: MaterialStateProperty.all(
                          Style.white.withOpacity(0.87)),
                      elevation: MaterialStateProperty.all(8),
                      shadowColor: MaterialStateProperty.all(Style.accent[50]),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                    ),
                    onPressed: () {
                      // apiPostRequest(context);
                    },
                    child: Text(
                      'Add Address'.tr,
                      style: Style.subtitle.copyWith(
                        fontSize: 18,
                        color: Colors.white,
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

  Widget textFields({String? label, TextEditingController? controller}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: Get.height / 15,
      child: TextFormField(
        controller: controller,
        cursorColor: Style.accent[500],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Style.accent[50]!.withOpacity(0.087),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0.8, color: Style.accent[50]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0.8, color: Style.prime[500]!),
          ),
          labelText: label,
          labelStyle: Style.subtitle.copyWith(
            fontSize: 14,
            color: Style.accent[100],
          ),
          floatingLabelStyle: Style.subtitle.copyWith(
            color: Style.prime[900],
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
