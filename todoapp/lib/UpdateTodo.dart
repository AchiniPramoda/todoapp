import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateTodo extends StatefulWidget {

  const UpdateTodo({Key? key, required this.TodoKey}) : super(key: key);
   


  final String TodoKey;
  

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final TodonameController = TextEditingController();
  final TodoidController = TextEditingController();
  final TododescriptionController = TextEditingController();
   FirebaseAuth _auth = FirebaseAuth.instance;
 
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("todos");
   
    getTodosviewData();
  }

  void getTodosviewData() async {
    DataSnapshot snapshot = await dbRef.get();

    Map animal = snapshot.value as Map;

    TodonameController.text = animal['todoname'];
    TodoidController.text = animal['todoid'];
    TododescriptionController.text = animal['tododesd'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: TodoidController,
              decoration: InputDecoration(
                labelText: 'Todo ID',
              ),
            ),
            TextFormField(
              controller: TodonameController,
              decoration: InputDecoration(
                labelText: 'Todo Name',
              ),
            ),
            TextFormField(
              controller: TododescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async{

                   final User? user = _auth.currentUser;
                    String id  = DateTime.now().millisecondsSinceEpoch.toString() ;
                    dbRef.child(id);
                
                await dbRef.child(id).update({  
                  
                  'todoname': TodonameController.text.toString(),
                  'todoid': TodoidController.text.toString(),
                  'tododesd': TododescriptionController.text.toString(),
                   
                    'id' : id
                  
                }).then((value) => Navigator.pop(context));
                 
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
