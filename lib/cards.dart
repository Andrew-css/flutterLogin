import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Card Design'), backgroundColor: Colors.black87, centerTitle: true,
        ),
        body: Container(
          color: const Color.fromARGB(255, 221, 237, 200),
          padding: const EdgeInsets.all(16.0),
          child: const Column(
          
            children: [
              MyCard(
                icon: Icons.photo_album,
                title: 'Photo Album',
                subtitle: 'TWICE',
                color: Color.fromARGB(255, 254, 172, 64),
                size: 150.0,
              ),
              SizedBox(height: 16.0),
              MyCard(
                icon: Icons.access_time, 
                title: 'Time',
                subtitle: 'TWICE',
                color: Color.fromARGB(255, 139, 195, 72),
                size: 150.0,
              ),
              SizedBox(height: 16.0),
              MyCard(
                icon: Icons.accessibility,
                title: 'Access',
                subtitle: 'TWICE',
                 color: Color.fromARGB(255, 254, 64, 128),
                size: 150.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final double size;

  const MyCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, size: 80.0),
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit')),
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),  
                   TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Create')),
                        );
                      },
                      child: const Text(
                        'Create',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
            
                  ),
                  const SizedBox(width: 15.0),  
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Delete')),
                      );
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}