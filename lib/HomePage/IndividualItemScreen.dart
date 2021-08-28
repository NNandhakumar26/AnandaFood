import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/Theme.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

ButtonStyle textButtonStyle() {
  return ButtonStyle(
    // backgroundColor:
    //     MaterialStateProperty.all<Color>(
    //         Colors.white.withOpacity(0.32)),
    overlayColor:
        MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.091)),
    // elevation:
    //     MaterialStateProperty.all<double>(5.0),
    padding: MaterialStateProperty.all<EdgeInsets>(
      EdgeInsets.fromLTRB(8, 4, 0, 4),
      // EdgeInsets.symmetric(
      //     horizontal: 24, vertical: 12),
    ),
  );
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 350,
                    width: Get.width,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Background.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: new RadialGradient(
                          radius: 0.85,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.32),
                            Colors.black.withOpacity(0.87),
                          ],
                        ),
                      ),
                      child: Image(
                        image: AssetImage(
                          'assets/images/Background.jpg',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 1,
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Share',
                                style: TextStyle(
                                  fontSize: 16,
                                  // letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.87),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.favorite_outline,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Description',
                      style: Style.title.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        backgroundColor: Style.primary,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Promo Code',
                            style: Style.subtitle.copyWith(
                              color: Colors.white.withOpacity(0.87),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.local_offer,
                            color: Colors.white.withOpacity(0.87),
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Container(
                  height: 120,
                  child: Text(
                    'A food with a sharp taste.A food with a sharp taste.A food with a sharp taste Often used to refer to tart or sour foods as well with less harsh taste than bitterness. Couples tartness with sweetness and has A bright flavor like that of lemons, limes, oranges, and other citrus fruits.',
                    style: Style.caption,
                    // style: TextStyle(
                    //   letterSpacing: 0.2,
                    //   wordSpacing: 0.4,
                    //   color: Style.accent.withOpacity(0.87),
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w300,
                    //   // fontStyle: 8,
                    // ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Combo With',
                      style: Style.title.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                height: 226,
                padding: EdgeInsets.symmetric(horizontal: 24),
                // color: Colors.deepOrange.withOpacity(0.87),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      width: 160,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      child: HalfSizedCards(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      bottomSheet: BottomSide(),
      // bottomSheet: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //   child: Container(
      //     color: Colors.red,
      //     height: 60,
      //     width: Get.width,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Row(
      //           children: [
      //             Column(
      //               children: [
      //                 Text('data'),
      //                 Text('data'),
      //               ],
      //             )
      //           ],
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Style.accent.withOpacity(0.67),
      //                 offset: const Offset(
      //                   1,
      //                   1,
      //                 ),
      //                 blurRadius: 5,
      //                 spreadRadius: 0.08,
      //               ),
      //               // BoxShadow(
      //               //   color: colors[index],
      //               //   offset: const Offset(
      //               //     0.81,
      //               //     0.8,
      //               //   ),
      //               //   blurRadius: 2,
      //               //   spreadRadius: 0.08,
      //               // ), //BoxShadow
      //               BoxShadow(
      //                 color: Colors.white,
      //                 offset: const Offset(
      //                   2,
      //                   2,
      //                 ),
      //                 blurRadius: 5,
      //                 spreadRadius: 0.08,
      //               ), //BoxShadow
      //             ],
      //           ),
      //           child: Text('data'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class BottomSide extends GetView {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // backgroundBlendMode: BlendMode.overlay,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.green,
        //     blurRadius: 5,
        //     spreadRadius: 0.5,
        //     offset: Offset(1, 1),
        //   ),
        //   BoxShadow(
        //     color: Colors.grey[50],
        //     blurRadius: 5,
        //     spreadRadius: 0.5,
        //     offset: Offset(1, 1),
        //   ),
        // ],
        color: Colors.transparent,
        // color: Style.background.withOpacity(0.87),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500,
                    color: Style.darkerText.withOpacity(0.87),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$ 50',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.87),
                      ),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w500,
                        color: Style.darkerText.withOpacity(0.60),
                      ),
                    ),
                    Text(
                      'Serve',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w500,
                        color: Style.darkerText.withOpacity(0.60),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 38,
            // width: MediaQuery.of(context).size.width / 2,
            // width: Get.width / 2,
            // ignore: deprecated_member_use
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                backgroundColor: Style.accent,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order Now',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.8,
                      color: Style.background.withOpacity(0.87),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    IconData(0xf37f, fontFamily: 'MaterialIcons'),
                    color: Colors.white.withOpacity(0.87),
                    size: 16,
                  )
                  // IconData(0xf37f, fontFamily: 'MaterialIcons'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HalfSizedCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ItemPage());
      },
      child: Card(
        elevation: 4,
        // color: Style.background.withOpacity(0.87),
        shadowColor: Style.accent.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  // topLeft: Radius.circular(8),
                  // bottomRight: Radius.circular(15),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Style.accent.withOpacity(0.67),
                //     offset: const Offset(
                //       1,
                //       1,
                //     ),
                //     blurRadius: 5,
                //     spreadRadius: 0.08,
                //   ),
                //   BoxShadow(
                //     color: Style.primary,
                //     offset: const Offset(
                //       0.81,
                //       0.8,
                //     ),
                //     blurRadius: 2,
                //     spreadRadius: 0.08,
                //   ), //BoxShadow
                //   BoxShadow(
                //     color: Colors.white,
                //     offset: const Offset(
                //       2,
                //       2,
                //     ),
                //     blurRadius: 5,
                //     spreadRadius: 0.08,
                //   ), //BoxShadow
                // ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.topRight,
                child: Container(
                  width: 30,
                  height: 25,
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.87),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Style.accent,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Style.primary50.withOpacity(0.01),
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Style.primary50,
                          ),
                          child: Text(
                            'Hot & Spicy',
                            style: Style.caption.copyWith(
                              fontSize: 8,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite_outline,
                              color: Style.accent.withOpacity(0.60),
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '23',
                              style: TextStyle(
                                fontSize: 10,
                                color: Style.accent.withOpacity(0.87),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'Butter Chicken',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: Style.title.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Most Favorite',
                          style: Style.body1.copyWith(
                            fontSize: 10,
                            color: Style.primary400,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          '\$ 3.5',
                          style: Style.body1.copyWith(
                            fontSize: 12,
                            color: Style.accentDark,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
