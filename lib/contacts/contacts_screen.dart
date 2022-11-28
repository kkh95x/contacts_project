import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  late List<Map<String, dynamic>> currentList;
  @override
  void initState() {
    currentList = listData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.west,color: Colors.black,size: 30,),
        title: const Text(
          "My Contacts",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              color: Colors.black,
              iconSize: 30,
              onPressed: () {
                showAddContactDialog();
                fullNameController.clear();
                numberPhoneController.clear();
              },
              icon: const Icon(Icons.add))
        ],
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getSearchInput(),
            listViewSp(currentList),
          ],
        ),
      ),
    );
  }

  Widget getSearchInput() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width,
      padding: const EdgeInsets.all(20),
      child: TextField(
        onChanged: ((value) {
          List<Map<String, dynamic>> contactWithThisName = searchContact(value);

          setState(() {
            currentList = contactWithThisName;
          });
        }),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search",
            filled: true,
            fillColor: Colors.grey.shade300,
            border: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.none, width: 0.0),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }

  List<Map<String, dynamic>> listData = [
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "ahmad mansor",
      "PhoneNumber": "(465) 1233423455"
    },
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "Khalid jasem",
      "PhoneNumber": "(465) 52454254"
    },
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "Abdulkarim Alkhatib",
      "PhoneNumber": "(465) 524524545"
    },
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "samir ahmed",
      "PhoneNumber": "(465) 25442344"
    },
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "vavjija mansor",
      "PhoneNumber": "(465) 254542"
    },
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "ajkjd mansor",
      "PhoneNumber": "(465) 2452"
    },
    {
      "image": "https://picsum.photos/200/200?random=",
      "fullName": "vadmkv mansor",
      "PhoneNumber": "254542"
    }
  ];
  Widget listViewSp(List<Map<String, dynamic>> listContacts) {
    Size size = MediaQuery.of(context).size;
    if (listContacts.length == 0) {
      return const Center(
        child: Text("Not Found"),
      );
    } else {
      return SizedBox(
        height: size.height * 0.75,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return mylistTile(listContacts[index], index);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 2,
              indent: 80,
            );
          },
          itemCount: listContacts.length,
        ),
      );
    }
  }

  Widget mylistTile(Map<String, dynamic> listData, int currentIndex) {
    return ListTile(
      leading: CircleAvatar(
          radius: 24,
          backgroundImage:
              NetworkImage(listData["image"]! + currentIndex.toString())),
      title: Text(
        listData["fullName"]!,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      subtitle: Text(
        listData["PhoneNumber"]!,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: Container(
        width: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: const Icon(Icons.edit, color: Colors.black),
              onTap: () {
                print(listData["fullName"]!);
                fullNameController.text = listData["fullName"]!;
                numberPhoneController.text = listData["PhoneNumber"]!;
                showEditDialog(currentIndex);
               
              },
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              child: const Icon(Icons.delete, color: Colors.black),
              onTap: () {
                showDeleteDialog(currentIndex);
              },
            ),
          ],
        ),
      ),
    );
  }

  showDeleteDialog(int currentIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text("Delete Worning"),
            content: Text("are you sure you wantdelet this contact"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                onPressed: () {
                  setState(() {
                    listData.removeAt(currentIndex);
                    currentList = listData;
                    Navigator.pop(context);
                  });
                },
                child: Text("Ok"),
              )
            ],
          ),
        );
      },
    );
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController numberPhoneController = TextEditingController();
  showEditDialog(int currentIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text("Edit Contant"),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(label: Text("FullName")),
                    controller: fullNameController,
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(label: Text("Phone Number")),
                    controller: numberPhoneController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                onPressed: () {
                  setState(() {
                    listData[currentIndex]["fullName"] =
                        fullNameController.text;
                    listData[currentIndex]["PhoneNumber"] =
                        numberPhoneController.text;
                    currentList = listData;
                    Navigator.pop(context);
                  });
                },
                child: Text("Ok"),
              )
            ],
          ),
        );
      },
    );
  }

  showAddContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text("Add Contact Contant"),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(label: Text("FullName")),
                    controller: fullNameController,
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(label: Text("Phone Number")),
                    controller: numberPhoneController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                onPressed: () {
                  setState(() {
                    listData.add({
                      "fullName": fullNameController.text,
                      "PhoneNumber": numberPhoneController.text,
                      "image": "https://picsum.photos/200/200?random"
                    });
                    currentList = listData;

                    Navigator.pop(context);
                  });
                },
                child: Text("Ok"),
              )
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> searchContact(String name) {
    List<Map<String, dynamic>> list = listData
        .where((element) => element["fullName"]!.startsWith(name))
        .toList();
    return list;
  }
}
