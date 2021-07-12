import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final String tabName;
  const TabBarWidget({Key key, @required this.tabName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 65,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: FittedBox(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .25,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .2,
              child: FittedBox(
                child: Text(
                  tabName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
