import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 20,letterSpacing: 1.25,color: Colors.grey),
  fillColor: Colors.black12 ,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)
  )
);

const appBarGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.cyan,
      Colors.indigo
    ]
); // app Bar Decoration

const buttonLinearGradient_1 = LinearGradient(
    colors: [
      Colors.teal,
      Colors.deepPurple
    ],
    begin: Alignment.bottomLeft ,
    end: Alignment.topRight ,
);

const buttonLinearGradient_2 = LinearGradient(
  colors: [
    Colors.deepPurple,
    Colors.teal,
  ],
  begin: Alignment.bottomLeft ,
  end: Alignment.topRight ,
);

const buttonRadialGradient_1 = RadialGradient(
  colors: [
    Colors.teal,
    Colors.deepPurple
  ],
  radius: 2.5,
  focal: Alignment(0.5, -0.5),
);

const buttonRadialGradient_2 = RadialGradient(
  colors: [
    Colors.teal,
    Colors.deepPurple,
  ],
  radius: 2.5,
  focal: Alignment(-0.5, 0.5),
);

BoxDecoration boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white, width: 2),
    );
}

Card menuCard(String text,String page,BuildContext context) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/$page");
      },
      child: Center(
        child: Text(
          text ,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

AppBar buildAppBar(String text,bool flag,BuildContext context) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(
        letterSpacing: 1.25 ,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: flag ? leadingIcon(context) : null
  );
} // Default app Bar propertires

Material leadingIcon(BuildContext context) {
  return Material(
    shape: const CircleBorder(),
    color: Colors.black54,
    child: InkWell(
      onTap: () {
          Navigator.pushNamed(context, "/menu");
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.list_rounded,
          color: Colors.white,
          size: 40,
        ),
      ),
    ),
  );
}