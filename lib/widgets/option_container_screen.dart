import 'package:flutter/material.dart';

class OptionContainer extends StatelessWidget {
  final String optionName;
  final IconData optionIcon;
  final Widget widgetName;

  const OptionContainer({
    this.optionName,
    this.optionIcon,
    this.widgetName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widgetName != null
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => widgetName))
          : null,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Icon(
                optionIcon,
                color: Theme.of(context).iconTheme.color,
                size: Theme.of(context).iconTheme.size,
              ),
              SizedBox(
                height: 5,
              ),
              FittedBox(
                child: Text(
                  optionName,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
