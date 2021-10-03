part of 'screen.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 48.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
