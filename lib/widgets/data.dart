import 'package:flutter/material.dart';

class Data extends StatelessWidget {
  Data({required this.title, required this.data, super.key});

  String title;
  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              "Foods",
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return Container(
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Center(
                    child: Text(data[0].name),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
