import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MechAccountPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MechAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white for consistency
      appBar: AppBar(
        title: Text('Mech Accounts', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4A8BDF),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildEarningsCard(),
            SizedBox(height: 12),
            buildOptionsCard(context),
          ],
        ),
      ),
    );
  }

  Widget buildEarningsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('TODAY, 08 MARCH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black54)),
          SizedBox(height: 6),
          Text('₹ 2,044', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.green)),
          SizedBox(height: 6),
          Text('4 SERVICES COMPLETED', style: TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget buildOptionsCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          buildOptionButton(Icons.account_balance, 'Bank Transfer', context, 'Bank Transfer Details', 
            'Your balance will be transferred to your linked bank account within 24 hours.'),
          Divider(color: Colors.grey[300], thickness: 1),

          buildOptionButton(Icons.history, 'Earning History', context, 'Earning History', 
            'Last Week: ₹10,520\nLast Month: ₹42,000\nTotal Earnings: ₹2,40,000'),
          Divider(color: Colors.grey[300], thickness: 1),

          buildOptionButton(Icons.card_giftcard, 'Incentives', context, 'Incentives', 
            'Bonus ₹500 for completing 10 services a day.\nExtra ₹1000 for working on weekends.'),
          Divider(color: Colors.grey[300], thickness: 1),

          buildOptionButton(Icons.star, 'Check Ratings', context, 'Ratings & Reviews', 
            'Your Rating: ⭐⭐⭐⭐ (4.5/5)\nCustomer Feedback: "Great service and very professional!"'),
          Divider(color: Colors.grey[300], thickness: 1),

          buildOptionButton(Icons.group, 'Refer & Earn', context, 'Refer & Earn', 
            'Invite friends and earn ₹200 for each successful referral.'),
        ],
      ),
    );
  }

  Widget buildOptionButton(IconData icon, String text, BuildContext context, String title, String details) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => DetailsPage(title: title, details: details, icon: icon),
        ));
      },
      splashColor: Colors.blue.withOpacity(0.2), // Button Click Effect
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10 ),
              decoration: BoxDecoration(
                color: const Color(0xFF4A8BDF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF4A8BDF), size: 28),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;
  final String details;
  final IconData icon;

  DetailsPage({required this.title, required this.details, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4A8BDF),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A8BDF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 48, color: const Color(0xFF4A8BDF)),
                ),
              ),
              SizedBox(height: 14),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 8),
              Text(details, style: TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}