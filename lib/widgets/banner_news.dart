import 'package:concise_clone/models/menu_items.dart';
import 'package:concise_clone/models/news_list_model.dart';
import 'package:concise_clone/widgets/menu_widget.dart';
import 'package:concise_clone/widgets/web_view.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';


class NewsBanner extends StatelessWidget {
  NewsListModel newsModel;

  NewsBanner(this.newsModel, {Key? key}) : super(key: key);

  void onShareText(BuildContext context, String? headline, String? link) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
        "Get the summary of the day at a glance. Download concise. \n${newsModel.listItemNewsLink}",
        subject: "subject",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  PopupMenuItem<MenuItemsClass> buildItem(MenuItemsClass item) =>
      PopupMenuItem<MenuItemsClass>(
          value: item,
          child: Row(
            children: [
              Icon(
                item.icon,
                color: Color(0xff1d425d),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                item.text,
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Color(0xff1d425d),fontFamily: 'Tinos-Regular'),
              ),
            ],
          ));

  void onSelected(BuildContext ctx, MenuItemsClass item) {
    switch (item) {
      case MenuItemsWidget.newsShare:
        onShareText(
            ctx, newsModel.listItemHeadLine, newsModel.listItemNewsLink);
        break;
      case MenuItemsWidget.newsReadMore:
        Navigator.of(ctx)
            .pushNamed(Web.routeName, arguments: newsModel.listItemNewsLink);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (newsModel.listItemHeadLine.isEmpty) {
      return SizedBox(
        height: 200,
        width: double.infinity,
        child: Card(
          child: Center(
            child: Text("Could Not Preview"),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Web.routeName, arguments: newsModel.listItemNewsLink);
        },
        child: Column(
          children: [
            Container(


              height: MediaQuery.of(context).size.height / 3.5,
              color: Colors.white,
              child: Card(

                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.black,
                        child: Opacity(
                          opacity: 0.45,
                          child: Image.network(
                            newsModel.listItemImageUrl,
                            height: MediaQuery.of(context).size.height / 3,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
                              return Container(
                                color: Colors.blueGrey[200],
                                height: MediaQuery.of(context).size.height / 3,
                                width: double.infinity,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width/20,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              newsModel.listItemHeadLine,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontFamily: 'Tinos-Regular'),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: PopupMenuButton<MenuItemsClass>(
                        onSelected: (item) => onSelected(context, item),
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          ...MenuItemsWidget.items.map(buildItem).toList(),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(
                  right: 22,
                  bottom: 10
              ),
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height/27,
              child: Text(newsModel.source,
                textAlign: TextAlign.end,
                style: TextStyle(color: Color(0xff1d425d),fontSize: 15,fontFamily: 'Tinos-Regular'),
              ),
            )
          ],
        ),
      );
    }
  }
}
