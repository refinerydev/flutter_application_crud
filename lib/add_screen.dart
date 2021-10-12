part of 'screen.dart';

class AddScreen extends StatefulWidget {
  final wo;

  AddScreen({
    Key? key,
    required this.wo,
  }) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Form Text Controller
  TextEditingController unitupiController = TextEditingController();
  TextEditingController unitapController = TextEditingController();
  TextEditingController unitupController = TextEditingController();
  TextEditingController idpelController = TextEditingController();
  TextEditingController blthContoller = TextEditingController();
  TextEditingController garduContoller = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();

  // Take Photo
  File? image;
  Future getImage() async {
    // Photo
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );

    image = File(imagePicked!.path);
    setState(() {});
  }

  // Dropdown Menu
  var status;
  List _statusList = [
    "Lunas",
    "Padam Sticker",
    "Padam Cabut McB",
    "Padam Bongkar Meter"
  ];

  // Position
  Position? _currentPosition;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      print(_currentPosition!.latitude);
      latController =
          TextEditingController(text: _currentPosition!.latitude.toString());
      print(_currentPosition!.longitude);
      longController =
          TextEditingController(text: _currentPosition!.longitude.toString());
    }).catchError((e) {
      print(e);
    });
  }

  // HTTP Post Data
  Future<bool> postData(
    String lat,
    String long,
    String unitupi,
    String idpel,
    File? image,
    String status,
  ) async {
    var uri = Uri.parse('http://tusbung.informasi-digital.info/create.php');

    var req = http.MultipartRequest(
      'POST',
      uri,
    );

    var photo = await http.MultipartFile.fromPath('picture_file', image!.path);

    req.fields['lat'] = lat.toString();
    req.fields['long'] = long.toString();
    req.fields['unitupi'] = unitupi.toString();
    req.fields['idpel'] = idpel.toString();
    req.fields['status'] = status.toString();
    req.files.add(photo);

    var res = await req.send();

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void initState() {
    super.initState();
    _getCurrentLocation();
    unitupiController = TextEditingController(text: widget.wo['UNITUPI']);
    unitapController = TextEditingController(text: widget.wo['UNITAP']);
    unitupController = TextEditingController(text: widget.wo['UNITUP']);
    idpelController = TextEditingController(text: widget.wo['IDPEL']);
    blthContoller = TextEditingController(text: widget.wo['BLTH']);
    garduContoller = TextEditingController(text: widget.wo['NAMA_GARDU']);
  }

  @override
  Widget build(BuildContext context) {
    Widget unitupiFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          readOnly: true,
          controller: unitupiController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'UID/UIW',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget unitapFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          readOnly: true,
          controller: unitapController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'UP3',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget unitupFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          readOnly: true,
          controller: unitupController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'ULP',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget idpelFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          readOnly: true,
          controller: idpelController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'Idpel',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget blthFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          readOnly: true,
          controller: blthContoller,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'BLTH',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget garduFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          readOnly: true,
          controller: garduContoller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Gardu',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget latFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          // enabled: false,
          readOnly: true,
          controller: latController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'Latitude',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget longFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          // enabled: false,
          readOnly: true,
          controller: longController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            labelText: 'Longitude',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget statusFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        padding: EdgeInsets.all(6),
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text("Pilih Kondisi Pemutusan"),
            value: status,
            items: _statusList.map((value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                status =
                    value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
              });
            },
          ),
        ),
      );
    }

    Widget takePhoto() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: image != null
            ? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.file(
                    image!,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.125,
                child: TextButton(
                  onPressed: () async {
                    await getImage();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
      );
    }

    Widget submitButton() {
      return Container(
        margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
        height: 48.0,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () async {
              // _getCurrentLocation();

              var ok = await postData(
                latController.text,
                longController.text,
                unitupiController.text,
                idpelController.text,
                image,
                status,
              );

              if (!ok) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      'Failed',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Success',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );

                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            child: Text(
              'Save',
              style: TextStyle(fontSize: 16.0),
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Data'),
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
              unitupiFormInput(),
              unitapFormInput(),
              unitupFormInput(),
              idpelFormInput(),
              blthFormInput(),
              garduFormInput(),
              latFormInput(),
              longFormInput(),
              statusFormInput(),
              takePhoto(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
