import 'package:flutter/material.dart';

import '../common/constants.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu>  {

  @override
  Widget build(BuildContext context)  {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: appBarGradient
                ),
              ),
              buildAppBar1("Menu")
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: boxDecoration(),
                      child: menuCard("New Admin", "newAdmin", context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: boxDecoration(),
                      child: menuCard("New Student","newStudent",context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: boxDecoration(),
                      child: menuCard("Student's List","list",context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: boxDecoration(),
                      child: menuCard("Daily Log","log",context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}