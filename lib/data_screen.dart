part of 'screen.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late List data = [];

  getData() async {
    var uri = Uri.parse('http://localhost/crudserver/readall.php');

    var response = await http.get(uri);

    var resBody = json.decode(response.body);

    setState(() {
      data = resBody;
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget addButton() {
      return Container(
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
      );
    }

    Widget cardData() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: data.map(
            (item) {
              return Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                item['description'],
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                      item: item,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit, size: 18),
                              label: Text("Edit"),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // Respond to button press
                              },
                              icon: Icon(Icons.delete, size: 18),
                              label: Text("Delete"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList()),
        ),
      );
    }

    return ListView(
      children: [
        addButton(),
        cardData(),
      ],
    );
  }
}
