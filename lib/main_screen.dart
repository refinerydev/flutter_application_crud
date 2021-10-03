part of 'screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (currentIndex) {
        case 0:
          return DashboardScreen();
        case 1:
          return DataScreen();
        default:
          return DashboardScreen();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 16.0,
        unselectedFontSize: 16.0,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Data',
            icon: Icon(Icons.table_view_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
        child: body(),
      ),
    );
  }
}
