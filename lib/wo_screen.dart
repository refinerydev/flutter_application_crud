part of 'screen.dart';

class WoScreen extends StatefulWidget {
  final List data;
  WoScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _WoScreenState createState() => _WoScreenState();
}

class _WoScreenState extends State<WoScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cardData() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: widget.data.map(
              (item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddScreen(
                          wo: item,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 400,
                    height: 95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          size: 70,
                          color: Colors.white,
                        ),
                        title: Text(
                          item['KODE_WO'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          item['IDPEL'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('WO List'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              cardData(),
            ],
          ),
        ),
      ),
    );
  }
}
