import 'package:digital_card_app/constants.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final List<ContactEntry> contacts = [
    ContactEntry("Name", "Job title", "Company"),
    ContactEntry("Example1", "Web designer", "Facebook"),
    ContactEntry("Example2", "Unemployed", ""),
  ];

  @override
  void dispose() {
    for (int i = 0; i < contacts.length; i++) {
      contacts[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text(
                      "When you share your card with people, they'll be able to send you their details, which will appear here!.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "DONE",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: logoRedColor),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.all_inbox_rounded)),
        title: Text(
          "Contacts",
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearch(
                context: context, delegate: ContactSearchDelegate(contacts)),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: contacts.length,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        contacts[index].getInitial(),
                      ),
                    ),
                    title: contacts[index].getName(context),
                    subtitle: contacts[index].getDetails(context),
                    isThreeLine: true,
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ContactEntry {
  final String name;
  final String title;
  final String subtitle;
  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController subtitleController;

  ContactEntry(this.name, this.title, this.subtitle)
      : nameController = TextEditingController(),
        titleController = TextEditingController(),
        subtitleController = TextEditingController();

  void dispose() {
    nameController.dispose();
    titleController.dispose();
    subtitleController.dispose();
  }

  Widget getName(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget getDetails(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title + "\n",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  String getInitial() {
    return name[0].toUpperCase();
  }
}

class ContactSearchDelegate extends SearchDelegate {
  final List<ContactEntry> contacts;

  ContactSearchDelegate(this.contacts);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          close(context, null);
          // clear
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Linear search
    // Not recommended, but should work for demostration.
    for (int i = 0; i < contacts.length; i++) {
      final ContactEntry entry = contacts[i];
      if (entry.name.toLowerCase() == query.toLowerCase()) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(entry.getInitial()),
            ),
            title: entry.getName(context),
            subtitle: entry.getDetails(context),
            isThreeLine: true,
          ),
        );
      }
    }
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
