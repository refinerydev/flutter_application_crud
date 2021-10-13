part of 'screen.dart';

class WoListScreen extends StatefulWidget {
  final String kodeWo;
  WoListScreen({
    Key? key,
    required this.kodeWo,
  }) : super(key: key);

  @override
  _WoListScreenState createState() => _WoListScreenState();
}

class _WoListScreenState extends State<WoListScreen> {
  late List data = [];

  getData(String kodeWo) async {
    var uri = Uri.parse(
        'http://tusbung.informasi-digital.info/readall.php?wo=$kodeWo');

    var response = await http.get(uri);

    var resBody = json.decode(response.body);

    setState(() {
      data = resBody;
    });

    if (data.isEmpty) {
      setState(() {
        card = false;
      });
    }
  }

  bool card = true;

  void initState() {
    super.initState();
    getData(widget.kodeWo);
  }

  @override
  Widget build(BuildContext context) {
    Widget cardData() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: data.map(
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
              card
                  ? cardData()
                  : Center(
                      child: Text(
                        'Tidak ada Data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
