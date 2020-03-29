import 'package:flutter/material.dart';

class GenericMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  final Function onPressed;

  const GenericMessage(
      {Key key, this.icon, this.title, this.message, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ],
          )),
    );
  }
}
