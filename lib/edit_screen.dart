part of 'screen.dart';

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  EditScreen({required this.item});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late var item = widget.item;

  void initState() {
    super.initState();
    titleController = TextEditingController(text: item['title']);
    descriptionController = TextEditingController(text: item['description']);
  }

  Future<bool> postitem(String title, String description) async {
    var uri = Uri.parse('http://localhost/crudserver/update.php');

    var req = http.MultipartRequest(
      'POST',
      uri,
    );

    req.fields['id'] = item['id'].toString();
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
              // postitem(
              //   titleController.text,
              //   descriptionController.text,
              // );

              var ok = await postitem(
                titleController.text,
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
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit item'),
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
            descriptionFormInput(),
            submitButton(),
          ],
        ),
      ),
    );
  }
}
