import 'package:flutter/material.dart';
import 'models/driver.dart';
import 'completion.dart';

class SummaryScreen extends StatelessWidget {
  final Driver driver;
  final String fromLocation;
  final String toLocation;

  const SummaryScreen({
    super.key,
    required this.driver,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildDriverInfo(),
          _buildCarInfo(),
          const Spacer(),
          _buildOrderButton(context),
          _buildTermsText(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF00ACC1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationText("16:30  $fromLocation", "Pick up at $fromLocation"),
          const SizedBox(height: 20),
          _buildLocationText("17:20  $toLocation", "Drop off at $toLocation"),
        ],
      ),
    );
  }

  Widget _buildLocationText(String time, String details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          details,
          style: const TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildDriverInfo() {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: ClipOval(
          child: Image.asset(
            "images/driver.png",
            fit: BoxFit.cover,
            width: 60,
            height: 60,
          ),
        ),
      ),
      title: const Text("Stephan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Row(
        children: const [
          Icon(Icons.star, color: Colors.amber, size: 18),
          SizedBox(width: 5),
          Text("4.99 (347 reviews)",
              style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCarInfo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
      child: Row(
        children: [
          Icon(Icons.directions_car, color: Colors.grey, size: 18),
          SizedBox(width: 10),
          Text("Big White Car", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildOrderButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const CompletionScreen()),
            (Route<dynamic> route) => false,
          );
        },
        child: const Text("Order Now",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Widget _buildTermsText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Text(
        "By clicking on 'Order Now' button I agree with Terms and Policies of using Carpoolin.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
