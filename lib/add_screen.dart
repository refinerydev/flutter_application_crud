part of 'screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController garduController = TextEditingController();

  var gardu;
  var kondisi;

  List _kondisiList = [
    "Lunas",
    "Padam Sticker",
    "Padam Cabut McB",
    "Padam Bongkar Meter"
  ];

  Future<bool> postData(String title, String description, String gardu) async {
    var uri = Uri.parse('http://localhost/API/restapi/create.php');

    var req = http.MultipartRequest(
      'POST',
      uri,
    );

    req.fields['title'] = title.toString();
    req.fields['description'] = description.toString();
    req.fields['gardu'] = gardu.toString();

    var res = await req.send();

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget unitupiFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          maxLength: 200,
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
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          maxLength: 200,
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
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          maxLength: 200,
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
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          maxLength: 12,
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
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          maxLength: 12,
          decoration: InputDecoration(
            labelText: 'Idpel',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget garduFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          controller: garduController,
          keyboardType: TextInputType.text,
          maxLength: 200,
          decoration: InputDecoration(
            labelText: 'gardu',
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
            hint: Text("Select Your Friends"),
            value: kondisi,
            items: _kondisiList.map((value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                kondisi =
                    value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
              });
            },
          ),
        ),
      );
    }

    Widget submitButton() {
      return Container(
        margin: EdgeInsets.only(top: 32.0),
        height: 48.0,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () async {
              // postData(
              //   titleController.text,
              //   descriptionController.text,
              // );

              var ok = await postData(
                titleController.text,
                descriptionController.text,
                garduController.text,
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
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
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
          child: Column(
            children: [
              titleFormInput(),
              unitupiFormInput(),
              unitapFormInput(),
              unitupFormInput(),
              idpelFormInput(),
              blthFormInput(),
              garduFormInput(),
              statusFormInput(),
              submitButton(),
            ],
          ),
        ));
  }
}
