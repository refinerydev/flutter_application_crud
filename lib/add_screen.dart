part of 'screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

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

    Widget descFormInput() {
      return Container(
        margin: EdgeInsets.only(top: 24.0),
        child: TextFormField(
          controller: descController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          maxLength: 200,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget submitButton() {
      return Container(
        margin: EdgeInsets.only(bottom: 24.0),
        height: 48.0,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {},
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
              descFormInput(),
              Spacer(),
              submitButton(),
            ],
          ),
        ));
  }
}
