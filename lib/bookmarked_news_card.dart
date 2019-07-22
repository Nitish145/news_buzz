import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookmarkedNewsCard extends StatefulWidget {
  final String photoUrl;
  final String title;
  final String description;
  final String content;
  final String url;

  const BookmarkedNewsCard(
      {Key key,
      this.photoUrl,
      this.title,
      this.description,
      this.content,
      this.url})
      : super(key: key);

  @override
  _BookmarkedNewsCardState createState() => _BookmarkedNewsCardState();
}

class _BookmarkedNewsCardState extends State<BookmarkedNewsCard> {
  @override
  Widget build(BuildContext context) {
    Future<void> launchURL(BuildContext context, String url) async {
      try {
        await launch(
          url,
          option: new CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            animation: new CustomTabsAnimation(
              startEnter: 'slide_up',
              startExit: 'android:anim/fade_out',
              endEnter: 'android:anim/fade_in',
              endExit: 'slide_down',
            ),
          ),
        );
      } catch (e) {
        // An exception is thrown if browser app is not installed on Android device.
        debugPrint(e.toString());
      }
    }

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Remove',
          color: Colors.grey,
          icon: Icons.remove_circle_outline,
          closeOnTap: true,
          onTap: () async {},
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () async {
            await launchURL(context, widget.url);
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: FadeInImage.memoryNetwork(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          fit: BoxFit.fill,
                          placeholder: kTransparentImage,
                          image: widget.photoUrl ??
                              "https://www.jainsusa.com/images/store/agriculture/not-available.jpg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 5.0),
                    child: Text(
                      widget.title ?? "",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
                    child: Text(
                      widget.content ?? "",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
