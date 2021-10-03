part of 'screen.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 48.0,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            icon: Icon(Icons.add, size: 16.0),
            label: Text(
              'Add',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
