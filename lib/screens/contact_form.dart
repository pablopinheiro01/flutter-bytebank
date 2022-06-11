import 'package:bytebank/database/dao/ContactDAO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactForm extends StatefulWidget {

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final ContactDAO dao= ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full name'
                ),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Account number'
              ),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: SizedBox(
                width: double.maxFinite,//preenche tudo conforme o tamanho do container
                child: ElevatedButton(onPressed: (){
                  final String name = _nameController.text;
                  final int? accountNumber = int.tryParse(_accountNumberController.text);
                  final newContact = Contact(0, name, accountNumber!);
                  dao.save(newContact).then((id) => Navigator.pop(context));
                },
                    child: Text('Create')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
