import 'package:flutter/material.dart';
import './wedgets/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, Map<String, dynamic>> cities = {
    'Beirut': {'temp': 27, 'desc': 'Sunny', 'humidity': 45, 'wind': 12, 'icon': 'sun'},
    'London': {'temp': 15, 'desc': 'Rainy', 'humidity': 81, 'wind': 8, 'icon': 'rain'},
    'Tokyo': {'temp': 22, 'desc': 'Cloudy', 'humidity': 60, 'wind': 6, 'icon': 'cloud'},
  };

  String selectedCity = 'Beirut';

  @override
  Widget build(BuildContext context) {
    final data = cities[selectedCity]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Offline'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCity,
              items: cities.keys
                  .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCity = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select City',
              ),
            ),

            const SizedBox(height: 20),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                );
              },

              child: WeatherCard(
                key: ValueKey(selectedCity), 
                city: selectedCity,
                temp: data['temp'],
                desc: data['desc'],
                humidity: data['humidity'],
                wind: data['wind'],
                iconName: data['icon'],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
