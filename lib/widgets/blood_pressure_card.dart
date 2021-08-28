import 'package:flutter/material.dart';

class BloodPressureCard extends StatefulWidget {
  const BloodPressureCard({Key key}) : super(key: key);

  @override
  _BloodPressureCardState createState() => _BloodPressureCardState();
}

class _BloodPressureCardState extends State<BloodPressureCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/blood_pressure_icon.png",
                  color: Colors.grey[700],
                  width: 27,
                ),
                Text(
                  " Blood pressure",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              text: ' 0/0',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' mmHg',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
