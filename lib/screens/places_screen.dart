import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {

  final List<Map<String, dynamic>> places = [
    {
      'name': 'Baga Beach',
      'visited': true,
    },
    {
      'name': 'Fort Aguada',
      'visited': false,
    },
    {
      'name': 'Dudhsagar Falls',
      'visited': false,
    },
    {
      'name': 'Basilica of Bom Jesus',
      'visited': false,
    },
  ];

  void addPlace() {

    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Add a place'),

          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter place name',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {

                if (controller.text.trim().isNotEmpty) {

                  setState(() {
                    places.add({
                      'name': controller.text.trim(),
                      'visited': false,
                    });
                  });

                  Navigator.pop(context);
                }
              },

              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Places to Visit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addPlace,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: places.length,

        itemBuilder: (context, index) {

          final place = places[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 10),

            child: CheckboxListTile(

              value: place['visited'],

              onChanged: (value) {

                setState(() {
                  place['visited'] = value;
                });

              },

              title: Text(
                place['name'],

                style: TextStyle(

                  fontWeight: FontWeight.w600,

                  decoration: place['visited']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),

              subtitle: Text(
                place['visited']
                    ? 'Visited'
                    : 'Not visited yet',
              ),

              secondary: Icon(
                Icons.location_on,
                color: place['visited']
                    ? Colors.green
                    : Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }
}