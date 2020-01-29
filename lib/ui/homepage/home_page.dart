import 'package:flutter/material.dart';
import 'package:localeventsapp/model/category.dart';
import 'package:localeventsapp/model/event.dart';
import 'package:localeventsapp/styleguide.dart';
import 'package:localeventsapp/ui/event_details/event_details_page.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import 'category_widget.dart';
import 'event_widget.dart';
import 'home_page_background.dart';

class HomePage extends StatelessWidget {
  String name ='My Wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NVODC EVENTS", style: fadedTextStyle),

        ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Card(
              child: UserAccountsDrawerHeader(
                accountName: new Text("Naomi A. Schultz"),
                accountEmail: new Text("NaomiASchultz@armyspy.com"),

                onDetailsPressed: () {

                },
                decoration: new BoxDecoration(
                  backgroundBlendMode: BlendMode.difference,
                  color: Colors.green,

                  /* image: new DecorationImage(
               //   image: new ExactAssetImage('assets/images/lake.jpeg'),
                  fit: BoxFit.cover,
                ),*/
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.fakenamegenerator.com/images/sil-female.png")),
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.history),
                      title: new Text("Booking History "),
                      onTap: () {

                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[

                  new ListTile(
                      leading: Icon(Icons.help),
                      title: new Text("Help"),
                      onTap: () {

                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text(
                    "Logout",
                    style:
                    new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                  ),
                  onTap: () {

                  }),
            )
          ],
        ),
      ),
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            HomePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[for (final category in categories) CategoryWidget(category: category)],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => Column(
                          children: <Widget>[
                            for (final event in events.where((e) => e.categoryIds.contains(appState.selectedCategoryId)))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EventDetailsPage(event: event),
                                    ),
                                  );
                                },
                                child: EventWidget(
                                  event: event,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
