import 'package:flutter/material.dart';

import '../Theme.dart';

class ItemCardListTile extends StatelessWidget {
  const ItemCardListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: Style.white,
      elevation: 16,
      shadowColor: Style.accent[50]!.withOpacity(0.16),
      borderOnForeground: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: ListTile(
          // minLeadingWidth: 32,
          leading: Container(
            color: Colors.red,
            child: Image(
              image: AssetImage('assets/images/Food1.png'),
            ),
          ),
          // leading: Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(16),
          //     color: Style.accent[500]!.withOpacity(0.087),
          //     // gradient: LinearGradient(
          //     //   begin: Alignment.bottomRight,
          //     //   end: Alignment.topLeft,
          //     //   colors: [
          //     //     Style.white,
          //     //     Style.accent[50]!.withOpacity(0.0016),
          //     //     Style.accent[50]!.withOpacity(0.087),
          //     //     Style.accent[50]!.withOpacity(0.016),
          //     //   ],
          //     // ),
          //   ),
          //   padding: EdgeInsets.all(8),
          //   child: Image(
          //     image: AssetImage('assets/images/Food1.png'),
          //     fit: BoxFit.contain,
          //   ),
          // ),

          isThreeLine: true,
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
                color: Style.prime.withOpacity(0.87),
                icon: Icon(
                  Icons.add,
                  color: Style.prime.withOpacity(0.87),
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
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      ),
    );
  }
}
