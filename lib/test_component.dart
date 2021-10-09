part of 'screen.dart';

class TestComponent extends StatefulWidget {
  @override
  _TestComponentState createState() => _TestComponentState();
}

class _TestComponentState extends State<TestComponent> {
  List<String> menuItem = ['Title1', 'Title2', 'Title3'];

  TextEditingController descriptionController = TextEditingController();
  String? title;

  Future<bool> postData(String title, String description) async {
    var uri = Uri.parse('http://localhost/crudserver/create.php');

    var req = http.MultipartRequest(
      'POST',
      uri,
    );

    req.fields['title'] = title.toString();
    req.fields['description'] = description.toString();

    var res = await req.send();

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleDropdownMenu() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 60,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
        child: DropdownMenu(
          menuItem: menuItem,
          hint: 'Choose One...',
          onPressed: (value) {
            setState(() {
              title = value;
            });
          },
        ),
      );
    }

    Widget descriptionFormInput() {
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
            labelText: 'descriptionription',
            border: OutlineInputBorder(),
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
            var ok = await postData(
              title.toString(),
              descriptionController.text,
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
          ),
        ),
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
            descriptionFormInput(),
            titleDropdownMenu(),
            submitButton(),
          ],
        ),
      ),
    );
  }
}
