import 'package:flutter/material.dart';

class BloodOxygenCard extends StatefulWidget {
  const BloodOxygenCard({Key key}) : super(key: key);

  @override
  _BloodOxygenCardState createState() => _BloodOxygenCardState();
}

class _BloodOxygenCardState extends State<BloodOxygenCard> {
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
                  "assets/icons/blood_oxygen_icon.png",
                  color: Colors.grey[700],
                  width: 29,
                ),
                Text(
                  " Blood oxygen",
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
              text: ' 0',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' %',
                  style: TextStyle(
                    fontSize: 14,
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
