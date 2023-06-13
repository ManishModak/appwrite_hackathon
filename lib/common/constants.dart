import 'package:flutter/material.dart';

 InputDecoration textInputDecoration = InputDecoration(
  hintStyle: const TextStyle(fontSize: 20,letterSpacing: 1.25,color: Colors.grey),
  fillColor: Colors.black12 ,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(12)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(12)
  ),
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
      borderRadius: BorderRadius.circular(12),
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

Card customCard(String text,BuildContext context) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        text ,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}

AppBar buildAppBar1(String text) {
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
  );
}

AppBar buildAppBar2(String text,BuildContext context) {
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
    leading: Material(
      shape: const CircleBorder(),
      color: Colors.transparent,
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
    )
  );
} // Default app Bar propertires

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String message,BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

EdgeInsets customPadding(Orientation orientation,double width) {
  if(orientation == Orientation.landscape)
  {
    return EdgeInsets.fromLTRB((width/6),5,(width/6),5) ;
  }
  else
  {
    return const EdgeInsets.all(8) ;
  }
}

TextStyle customText(Orientation orientation) {
  if(orientation == Orientation.landscape)
  {
    return const TextStyle(fontSize: 30,color: Colors.white) ;
  }
  else
  {
    return  const TextStyle(color: Colors.white) ;
  }
}

double customFontSize(Orientation orientation,double width) {
  if(orientation == Orientation.landscape)
  {
    return (width/12)-20 ;
  }
  else
  {
    return width/24 ;
  }
}
