import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/HomePage/MainPageContainer.dart';
import 'package:subscription_mobile_app/Theme.dart';

import 'IndividualItemScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final input = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverAppBar(
              //TODO: CHANGE IT TO APPROPRIATE BACKGROUND COLOUR
              backgroundColor: Style.white,
              foregroundColor: Style.accent[500],
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: Get.height / 1.7,
              centerTitle: true,
              leading: Container(),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: Text(
                  'Subscription App'.toUpperCase(),
                  style: Style.subtitle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.8,
                    color: Style.accent[500],
                    shadows: [
                      Shadow(
                        color: Style.prime[50]!.withOpacity(0.32),
                        blurRadius: 8,
                        offset: Offset(0.8, 0.8),
                      ),
                    ],
                  ),
                ),
                titlePadding: EdgeInsets.all(8),
                background: MainPageContainer(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: const Text(
                    'Advertising HOT SALE Text Here ( can be disabled)',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.all(8),
                    color: Style.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height / 36,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            left: 6,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'Hi, ',
                                    style: Style.subtitle.copyWith(
                                      letterSpacing: 0.4,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Style.accent[400],
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Blue',
                                        style: Style.subtitle.copyWith(
                                          letterSpacing: 0.8,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Style.prime[900],
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Let\'s Have Some Delicious Food',
                                style: Style.body2.copyWith(
                                  color: Style.accent[300],
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height / 48,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8.0),
                              child: Text(
                                'Objectives',
                                textAlign: TextAlign.left,
                                style: Style.title.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Style.accent[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height / 64,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 8),
                                    child: Container(
                                      height: Get.height / 7,
                                      decoration: BoxDecoration(
                                        color: Style.prime[500],
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: Style.prime[50]!,
                                            offset: Offset(2, 2),
                                            spreadRadius: 0.5,
                                          ),
                                          BoxShadow(
                                            blurRadius: 8,
                                            color: Style.prime[200]!,
                                            offset: Offset(2, 2),
                                            spreadRadius: 0.5,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.food_bank_outlined,
                                            size: 50,
                                            color:
                                                Style.white.withOpacity(0.87),
                                          ),
                                          Text(
                                            'Slim',
                                            style: TextStyle(
                                              color: Style.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.6,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HalfSizedCards2(
                                    title: 'Healthy',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: HalfSizedCards2(
                                    title: 'Gain Weight',
                                  ),
                                ),
                                Expanded(
                                  child: HalfSizedCards2(
                                    title: 'Body Building',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Companies',
                                style: Style.title.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Style.black.withOpacity(0.87)),
                              ),
                              TitleRow(
                                sub: 'View All',
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CompanyContainers(
                                title: 'Food Circles',
                                image: 'assets/images/Hotel.png',
                              ),
                              CompanyContainers(
                                title: 'Chicken Kitchen',
                                image: 'assets/images/Hotel1.jpg',
                              ),
                              CompanyContainers(
                                title: 'Butterfly Restaurant',
                                image: 'assets/images/Hotel2.jpg',
                              ),
                              CompanyContainers(
                                title: 'JagerHaus Restaurant',
                                image: 'assets/images/Hotel3.jpg',
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Categories',
                                style: Style.title.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Style.black.withOpacity(0.87)),
                              ),
                              TitleRow(
                                sub: 'See All',
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 240,
                          // color: Colors.deepOrange.withOpacity(0.87),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 250,
                                width: 160,
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                child: HalfSizedCards(),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Deals Of The Day!'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: thisPageStyle.copyWith(
                                  fontSize: 20,
                                  color: Style.black.withOpacity(0.80),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // TextButton(
                              //   style: textButtonStyle(),
                              //   onPressed: () {},
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         'Claim More'.toUpperCase(),
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 12,
                              //           color: Style.primary.withOpacity(0.60),
                              //         ),
                              //         // ),
                              //         // style: TextStyle(
                              //         //   color: Colors.purple.shade900,
                              //         //   fontWeight: FontWeight.bold,
                              //         //   letterSpacing: 1.0,
                              //         //   fontSize: 12,
                              //         // ),
                              //       ),
                              //       Icon(
                              //         Icons.arrow_right,
                              //         color: Style.primary,
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        //TODO: CHECK FOR THE IMBALANCE IN STYLE HERE
                        Container(
                          height: Get.height / 2.58,
                          width: Get.width / 1.091,
                          color: Colors.grey.withOpacity(0.03),
                          // color: Colors.red,
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              // childAspectRatio: 1,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                              mainAxisExtent: 80,
                            ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                height: 320,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.elliptical(8, 8)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Style.accent.withOpacity(0.67),
                                      offset: const Offset(
                                        1,
                                        1,
                                      ),
                                      blurRadius: 5,
                                      spreadRadius: 0.08,
                                    ),
                                    BoxShadow(
                                      color: Style.colors[index]!,
                                      offset: const Offset(
                                        0.81,
                                        0.8,
                                      ),
                                      blurRadius: 2,
                                      spreadRadius: 0.08,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(
                                        2,
                                        2,
                                      ),
                                      blurRadius: 5,
                                      spreadRadius: 0.08,
                                    ), //BoxShadow
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/Background.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(8, 8)),
                                    color:
                                        Style.colors[index]!.withOpacity(0.7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Desserts',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.87),
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Order Now',
                                style: thisPageStyle,
                              ),
                              TitleRow(
                                sub: 'Explore',
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shadowColor: Style.primary50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: ListTile(
                              leading: Material(
                                elevation: 2,
                                shadowColor: Style.primary.withOpacity(0.60),
                                child: Image(
                                  image: AssetImage('assets/images/Food1.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // leading: Card(
                              //   elevation: 4.0,
                              //   shape: CircleBorder(side: BorderSide.none),
                              //   borderOnForeground: true,
                              //   // shadowColor: Style.primary.withOpacity(0.2),
                              //   clipBehavior: Clip.antiAlias,
                              //   child: CircleAvatar(
                              //     maxRadius: 32.0,
                              //     minRadius: 24,
                              //     backgroundColor:
                              //         Style.background.withOpacity(0.8),
                              //     child: Image(
                              //       image: AssetImage('assets/images/Food1.png'),
                              //       fit: BoxFit.contain,
                              //     ),
                              //   ),
                              // ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    color: Style.primary.withOpacity(0.87),
                                    icon: Icon(
                                      Icons.add,
                                      color: Style.primary.withOpacity(0.87),
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Style.accent.withOpacity(0.87),
                                    ),
                                  ),
                                ],
                              ),
                              title: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Spizy Hot Sale',
                                  style: Style.title.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                'Order Now',
                                style: Style.subtitle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              // isThreeLine: true,
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                            ),
                          ),
                        ),

                        Card(
                          elevation: 2,
                          shadowColor: Style.primary50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: ListTile(
                              leading: Material(
                                elevation: 2,
                                shadowColor: Style.primary.withOpacity(0.60),
                                child: Image(
                                  image: AssetImage('assets/images/Food1.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // leading: Card(
                              //   elevation: 4.0,
                              //   shape: CircleBorder(side: BorderSide.none),
                              //   borderOnForeground: true,
                              //   // shadowColor: Style.primary.withOpacity(0.2),
                              //   clipBehavior: Clip.antiAlias,
                              //   child: CircleAvatar(
                              //     maxRadius: 32.0,
                              //     minRadius: 24,
                              //     backgroundColor:
                              //         Style.background.withOpacity(0.8),
                              //     child: Image(
                              //       image: AssetImage('assets/images/Food1.png'),
                              //       fit: BoxFit.contain,
                              //     ),
                              //   ),
                              // ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    color: Style.primary.withOpacity(0.87),
                                    icon: Icon(
                                      Icons.add,
                                      color: Style.primary.withOpacity(0.87),
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Style.accent.withOpacity(0.87),
                                    ),
                                  ),
                                ],
                              ),
                              title: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Spizy Hot Sale',
                                  style: Style.title.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                'Order Now',
                                style: Style.subtitle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              // isThreeLine: true,
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shadowColor: Style.primary50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: ListTile(
                              leading: Material(
                                elevation: 2,
                                shadowColor: Style.primary.withOpacity(0.60),
                                child: Image(
                                  image: AssetImage('assets/images/Food1.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // leading: Card(
                              //   elevation: 4.0,
                              //   shape: CircleBorder(side: BorderSide.none),
                              //   borderOnForeground: true,
                              //   // shadowColor: Style.primary.withOpacity(0.2),
                              //   clipBehavior: Clip.antiAlias,
                              //   child: CircleAvatar(
                              //     maxRadius: 32.0,
                              //     minRadius: 24,
                              //     backgroundColor:
                              //         Style.background.withOpacity(0.8),
                              //     child: Image(
                              //       image: AssetImage('assets/images/Food1.png'),
                              //       fit: BoxFit.contain,
                              //     ),
                              //   ),
                              // ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    color: Style.primary.withOpacity(0.87),
                                    icon: Icon(
                                      Icons.add,
                                      color: Style.primary.withOpacity(0.87),
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Style.accent.withOpacity(0.87),
                                    ),
                                  ),
                                ],
                              ),
                              title: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Spizy Hot Sale',
                                  style: Style.title.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                'Order Now',
                                style: Style.subtitle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              // isThreeLine: true,
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Hot Wings',
                                style: thisPageStyle,
                              ),
                              TitleRow(
                                sub: 'See All',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle thisPageStyle = Style.title.copyWith(
    fontWeight: FontWeight.w600,
    color: Style.black.withOpacity(0.87),
  );
}

class TitleRow extends StatelessWidget {
  final sub;

  TitleRow({this.sub});

  @override
  Widget build(BuildContext context) {
    ButtonStyle textButtonStyle() {
      return ButtonStyle(
        // backgroundColor:
        //     MaterialStateProperty.all<Color>(
        //         Colors.white.withOpacity(0.32)),
        overlayColor: MaterialStateProperty.all<Color>(
            Style.dark_grey.withOpacity(0.091)),
        // elevation:
        //     MaterialStateProperty.all<double>(5.0),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.fromLTRB(8, 4, 0, 4),
          // EdgeInsets.symmetric(
          //     horizontal: 24, vertical: 12),
        ),
      );
    }

    return TextButton(
      style: textButtonStyle(),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            sub.toUpperCase(),
            style: Style.subtitle.copyWith(
              fontSize: 12,
              color: Style.accent.withOpacity(0.60),
            ),
          ),
          Icon(
            Icons.arrow_right,
            color: Style.accent.withOpacity(0.87),
          )
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
        elevation: 8,
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
                  // color: Style.prime.withOpacity(0.0982),
                  color: Style.white.withOpacity(0.87),
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
                            color: Style.prime.withOpacity(0.2),
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
                            color: Style.prime[500],
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          '\$ 3.5',
                          style: Style.body1.copyWith(
                            fontSize: 12,
                            color: Style.accent[900],
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

class HalfSizedCards2 extends StatelessWidget {
  final String title;
  HalfSizedCards2({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Container(
        height: Get.height / 7,
        decoration: BoxDecoration(
          color: Style.accent.withOpacity(0.08),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.food_bank_outlined,
              size: 50,
              color: Style.accent.withOpacity(0.60),
            ),
            Text(
              title,
              style: Style.subtitle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.4,
                color: Style.accent[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyContainers extends StatelessWidget {
  final title;
  final subTitle;
  final rating;
  final image;
  final color;
  final textColor;

  CompanyContainers(
      {this.title,
      this.subTitle,
      this.rating,
      this.color,
      this.textColor,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: Get.height / 3.6,
      width: Get.width / 2,
      // color: Colors.blue.withOpacity(0.1),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: Get.height / 12,
            child: Container(
              padding:
                  EdgeInsets.only(left: 12, top: Get.height / 20, bottom: 8),
              decoration: BoxDecoration(
                color: color ?? Style.prime[50]!.withOpacity(0.16),
                border: Border.all(width: 0, color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(24.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title ?? 'Anandha Bhavan Restaurant',
                      style: TextStyle(
                        color: textColor ?? Style.accent,
                        fontSize: 14,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w400,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  // Text(
                  //   rating ?? '4.5',
                  //   style: TextStyle(
                  //     color: textColor.withOpacity(0.87),
                  //     fontSize: Get.width / 32,
                  //     letterSpacing: 1.5,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),

                  SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4),
                      child: Text(
                        subTitle ?? 'View More',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: textColor ?? Style.prime[900],
                          fontSize: Get.width / 32,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Get.height / 8,
                width: Get.height / 6,
                child: Image(
                  image: (image == null)
                      ? AssetImage('assets/images/Hotel.png')
                      : AssetImage(image),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
