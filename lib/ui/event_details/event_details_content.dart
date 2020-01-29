import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/event.dart';
import '../../model/guest.dart';
import '../../styleguide.dart';

class EventDetailsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(
              event.title,
              style: eventWhiteTitleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  Text(
                    "-",
                    style: eventLocationTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    event.location,
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: event.punchLine1, style: punchLine1TextStyle,),
                  TextSpan(text: event.punchLine2, style: punchLine2TextStyle,),
                ]
              ),
            ),
          ),

          if (event.description.isNotEmpty)  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 0),
                  child: Text(
                    "EVENT SCHEDULE",
                    style: guestTextStyle,
                  ),
                ),
                SizedBox(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10.0),
                    children: event.eventSchedule.reversed.map((data) {
                      return Card(child: ListTile(
                        leading: Text(data.time),
                        title: Text(data.description),
                      ));
                    }).toList(),
                  ),
                ),


              ],
            ),

          if (event.galleryImages.isNotEmpty) Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
            child: Text(
              "GALLERY",
              style: guestTextStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (final galleryImagePath in event.galleryImages)
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        galleryImagePath,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
