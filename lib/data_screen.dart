part of 'screen.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  TextEditingController searchController = TextEditingController();

  late List data = [];

  getData() async {
    var uri = Uri.parse('http://tusbung.informasi-digital.info/readall.php');

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
    Widget crossing() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 120,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Cari Berdasarkan Kode WO',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WoListScreen(kodeWo: searchController.text),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.search,
                    size: 28,
                  ),
                )),
          ],
        ),
      );
    }

    Widget cardData() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: Column(
          children: data.map(
            (item) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WoScreen(
                        data: item['DATA'],
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
                        Icons.data_usage,
                        size: 70,
                        color: Colors.white,
                      ),
                      title: Text(
                        item['KDDK'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'WO: 100/100',
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Column(
              children: [
                crossing(),
                cardData(),
              ],
            ),
          ),
        ));
  }
}
