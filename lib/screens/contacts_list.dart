

import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: FutureBuilder<List<Contact>>(
        // initialData: [], //insere um valor inicial
        future: Future.delayed(Duration(seconds: 3)) //seta um delay na busca para simular uma chamada async
            .then((value) => findAll()),//busca todos os contatos
        builder: (context, snapshot) { //quando tiver a resposta modifica o builder
          switch(snapshot.connectionState){
            case ConnectionState.none: //future ainda nao foi executado
              break;
            case ConnectionState.waiting: //verifica que o future ainda esta carregando
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading...')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              //significa que tem dado disponivel mas ainda nao foi finalizado o future
              //usado por exemplo em download, mostrando o progresso continuo
              break;
            case ConnectionState.done:
              if(snapshot.data != null){
                final List<Contact> contacts = snapshot.data as List<Contact>;
                return ListView.builder(
                  itemBuilder: (context, index){
                    return _ContactItem(contacts[index]);
                  },
                  itemCount: contacts.length,
                );
              }
              break;
          }
          return Text('Unknown error');//provavelmente nunca caira nesse bloco
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => ContactForm(),
              ),
          ).then((value) => setState((){}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget{

  final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contact.name, style: TextStyle(fontSize: 24),),
        subtitle: Text(contact.accountNumber.toString()),
      ),
    );
  }

}
