// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Webler',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // The contents of views
  // Only the content associated with the selected tab is displayed on the screen
  final List<Widget> _mainContents = [
    // Content for Home tab
    Container(
      color: Colors.yellow.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Feed tab
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Social',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Favorites tab
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Learn',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Color.fromARGB(255, 66, 102, 126),
      alignment: Alignment.center,
      child: const Text(
        'Q&A',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Settings tab
    Container(
      color: Colors.pink.shade300,
      alignment: Alignment.center,
      child: const Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      ),
    )
  ];

  // The index of the selected tab
  // In the beginning, the Home tab is selected
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Webler'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search for something in Webler',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'Coming soon. We will add searchbar later, preferably on the top banner.')));
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          tooltip: 'Open notifications',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Notifications'),
                  ),
                  body: const Center(
                    child: Text(
                      'You have no notifications',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ));
          },
        ),
        const SizedBox(
          height: 8,
        ),
        const CircleAvatar(
          radius: 20,
          child: Icon(Icons.person),
        ),
      ]),
      // Show the bottom tab bar if screen width < 640
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              // called when one tab is selected
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // bottom tab items
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: 'Social'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.school), label: 'Learn'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.assistant), label: 'Q&A'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.code), label: 'Codes')
                ])
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Show the navigaiton rail if screen width >= 640
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              minWidth: 55.0,
              selectedIndex: _selectedIndex,
              // Called when one tab is selected
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Color.fromARGB(255, 13, 46, 138),
              ),
              unselectedLabelTextStyle: const TextStyle(),
              // navigation rail items
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.people), label: Text('Social')),
                NavigationRailDestination(
                    icon: Icon(Icons.school), label: Text('Learn')),
                NavigationRailDestination(
                    icon: Icon(Icons.assistant), label: Text('Q&A')),
                NavigationRailDestination(
                    icon: Icon(Icons.code), label: Text('Codes'))
              ],
            ),

          // Main content
          // This part is always shown
          // You will see it on both small and wide screen
          Expanded(child: _mainContents[_selectedIndex]),
        ],
      ),
    );
  }
}
