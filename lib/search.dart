import 'package:flutter/material.dart';
import 'models/driver.dart';
import 'summary.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int passengers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBox(),
          _buildDetailsSection(),
          _buildSearchButton(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Buscar un viaje"),
      backgroundColor: Colors.teal,
      elevation: 0,
    );
  }

  Widget _buildSearchBox() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("¿A dónde quieres ir?",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          _buildTextField(controller: fromController, label: "Desde"),
          _buildTextField(controller: toController, label: "Hasta"),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildDetailsSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelection(),
            const SizedBox(height: 16),
            _buildPassengerSelection(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Fecha", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            _buildDateButton("Hoy", DateTime.now()),
            _buildDateButton("Mañana", DateTime.now().add(const Duration(days: 1))),
          ],
        ),
      ],
    );
  }

  Widget _buildDateButton(String label, DateTime date) {
    return TextButton(
      onPressed: () => setState(() => selectedDate = date),
      child: Text(label,
          style: TextStyle(color: selectedDate.day == date.day ? Colors.blue : Colors.grey)),
    );
  }

  Widget _buildPassengerSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pasajeros", style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<int>(
          value: passengers,
          isExpanded: true,
          items: List.generate(5, (index) => index + 1)
              .map((value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text("$value Pasajeros"),
                  ))
              .toList(),
          onChanged: (value) => setState(() => passengers = value!),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onSearchPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: const Text("Buscar",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  void _onSearchPressed() {
    if (fromController.text.isNotEmpty && toController.text.isNotEmpty) {
      Driver exampleDriver = Driver(
        name: "Juan Pérez",
        car: "Toyota Corolla",
        rating: 4.8,
        reviews: 120,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryScreen(
            driver: exampleDriver,
            fromLocation: fromController.text,
            toLocation: toController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
    }
  }
}
