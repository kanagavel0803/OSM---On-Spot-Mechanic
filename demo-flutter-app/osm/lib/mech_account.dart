import 'package:flutter/material.dart';
import 'mech_duty.dart';
import 'mech_profile.dart';

class MechAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mech Accounts'),
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
      ),
      body: Container(
        color: Color.fromARGB(255, 31, 157, 161),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromARGB(255, 200, 162, 146),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'TODAY, 08 MARCH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '₹ 2,044',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '4 SERVICES COMPLETED',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildArrowIcon(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromARGB(255, 200, 162, 146),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildButtonRow(Icons.attach_money, 'Bank Transfer', context, '/bankTransfer'),
                  SizedBox(height: 5),
                  buildButtonRow(Icons.history, 'Earning History', context, '/earningHistory'),
                  SizedBox(height: 5),
                  buildButtonRow(Icons.local_offer, 'Incentives', context, '/incentives'),
                  SizedBox(height: 5),
                  buildButtonRow(Icons.star, 'Check Ratings', context, '/checkRatings'),
                  SizedBox(height: 5),
                  buildButtonRow(Icons.group, 'Refer & Earn', context, '/referAndEarn'),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 200, 162, 146),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechDutyPage()),
                );
              },
              child: buildBottomIcon(Icons.build, 'Duty'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechAccountPage()),
                );
              },
              child: buildBottomIcon(Icons.account_circle, 'Accounts'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechProfilePage()),
                );
              },
              child: buildBottomIcon(Icons.person, 'Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildArrowIcon() {
    return Icon(Icons.arrow_forward, color: const Color.fromARGB(255, 255, 255, 255), size: 20);
  }

  Widget buildButtonRow(IconData iconData, String text, BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(iconData),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
              color: Colors.black12,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomIcon(IconData iconData, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 24),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}