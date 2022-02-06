import 'package:concise_clone/models/news_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class ConciseApi with ChangeNotifier {
  List<NewsListModel> indiaToday = [];
  List<NewsListModel> theEconomicTimes = [];
  List<NewsListModel> ndtv = [];
  List<NewsListModel> hindustanTimes = [];
  List<NewsListModel> beebom = [];
  List<NewsListModel> abpLive = [];
  List<NewsListModel> bollywoodHungama = [];
  List<NewsListModel> firstPost = [];

  List<NewsListModel> latestNews = [];

  Future<void> extractFromIndiaToday() async {
    var finalNewsImage;
    var sourceUrl = 'https://www.indiatoday.in/india';
    final response = await http.Client().get(Uri.parse(sourceUrl));
    if (response.statusCode == 200) {
      var doc =
          parser.parse(response.body).getElementsByClassName('view-content')[0];
      try {
        for (int i = 0; i < 12; i++) {
          //Get News Link------------------
          var newsLink = doc.children[i].children[1].children[0]
              .getElementsByTagName('a')
              .where((element) => element.attributes.containsKey('href'))
              .map((e) => e.attributes['href'])
              .toList();
          String subLink =
              newsLink.toString().substring(1, newsLink.toString().length - 1);
          var link = '';
          for (int i = 0; i < subLink.length; i++) {
            if (subLink[i] == ',') {
              break;
            }
            link += subLink[i];
          }
          sourceUrl = 'https://www.indiatoday.in' + link;

          //Get News Image-------------------
          var newsImage = doc.children[i].children[0]
              .getElementsByTagName('img')
              .where((element) => element.attributes.containsKey('src'))
              .map((e) => e.attributes['src'])
              .toList();
          finalNewsImage = newsImage.toString();
          finalNewsImage = finalNewsImage.replaceAll('[', '');
          finalNewsImage = finalNewsImage.replaceAll(']', '');

          //Get Headline
          var newsHeadLine = doc.children[i].getElementsByTagName('h2')[0];

          if (link.isNotEmpty) {
            indiaToday.add(NewsListModel(
                listItemImageUrl: finalNewsImage,
                listItemHeadLine: newsHeadLine.text.toString(),
                listItemNewsLink: sourceUrl,
                isBanner: false,
                date: DateTime.now().toString(),
                source: 'India Today'));
          }
        }
      } catch (e) {
        print('ERROR IN FETCHING DATA');
      }
    } else {
      print('ERROR CONNECTING TO SERVER');
    }
  }

  Future<void> extractFromTheEconomicTimes() async {
    final url = Uri.parse('https://economictimes.indiatimes.com/news/india');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      try {
        final element = document
            .getElementsByClassName('tabdata')[0]
            .getElementsByClassName('eachStory');
        List<String?> newsLink = element
            .map((element) =>
                element.getElementsByTagName('a')[0].attributes['href'])
            .toList();
        List<String?> imageUrl = element
            .map((element) => element
                .getElementsByTagName('img')[0]
                .attributes['data-original'])
            .toList();
        List<dom.Element> newsHeadline = element
            .map((element) => element.getElementsByTagName('h3')[0])
            .toList();


        for (int i = 0; i < newsHeadline.length; i++) {

          theEconomicTimes.add(NewsListModel(
              listItemImageUrl: imageUrl[i]!,
              listItemHeadLine: newsHeadline[i].text.toString(),
              listItemNewsLink:
                  'https://economictimes.indiatimes.com' + newsLink[i]!,
              isBanner: false,
              date: DateTime.now().toString(),
              source: 'The Economic Times'));
        }
      } catch (e) {
        print("Error Getting Data");
      }
    } else {
      print("Couldn't connect to server");
    }
  }

  Future<void> extractFromNDTV() async {
    var finalNewsImage;
    var sourceUrl = 'https://www.ndtv.com/latest#pfrom=home-ndtv_mainnavgation';
    final response = await http.Client().get(Uri.parse(sourceUrl));
    if (response.statusCode == 200) {
      var doc =
          parser.parse(response.body).getElementsByClassName('lisingNews')[0];
      try {
        for (int i = 0; i < 16; i++) {
          if (i == 3 || i == 7) {
            continue;
          }
          //Get News Link------------------
          var newsLink = doc.children[i]
              .getElementsByClassName('news_Itm-img')[0]
              .getElementsByTagName('a')
              .where((element) => element.attributes.containsKey('href'))
              .map((e) => e.attributes['href'])
              .toString();

          newsLink = newsLink.replaceAll('(', '');
          newsLink = newsLink.replaceAll(')', '');

          //Get News Image-------------------
          var newsImage = doc.children[i]
              .getElementsByClassName('news_Itm-img')[0]
              .getElementsByTagName('img')
              .where((element) => element.attributes.containsKey('src'))
              .map((e) => e.attributes['src']);

          finalNewsImage = newsImage.toString();
          finalNewsImage = finalNewsImage.replaceAll('(', '');
          finalNewsImage = finalNewsImage.replaceAll(')', '');

          //Get Headline
          var newsHeadLine =
              doc.children[i].getElementsByClassName('newsHdng')[0];

          //
          if (newsLink.isNotEmpty) {
            ndtv.add(NewsListModel(
                listItemImageUrl: finalNewsImage,
                listItemHeadLine: newsHeadLine.text.toString(),
                listItemNewsLink: newsLink,
                isBanner: false,
                date: DateTime.now().toString(),
                source: 'NDTV'));
          }

        }
        //Return The NewsModelList
      } catch (e) {
        print('ERROR IN FETCHING DATA');
      }
    } else {
      print('Could Not connect to the URL');
    }
  }

  Future<void> extractFromHindustanTimes() async {
    var finalNewsImage;
    var sourceUrl = 'https://www.hindustantimes.com/india-news';
    final response = await http.Client().get(Uri.parse(sourceUrl));
    if (response.statusCode == 200) {
      var doc =
          parser.parse(response.body).getElementsByClassName('listingPage')[0];
      try {
        for (int i = 0; i < 30; i++) {
          if (i == 0 || i == 3 || i % 4 == 0) {
            continue;
          }
          //Get News Link------------------
          var newsLink = doc.children[i]
              .getElementsByTagName('h3')[0]
              .getElementsByTagName('a')
              .where((element) => element.attributes.containsKey('href'))
              .map((e) => e.attributes['href']);

          String subLink =
              newsLink.toString().substring(1, newsLink.toString().length - 1);
          var link = '';
          for (int i = 0; i < subLink.length; i++) {
            if (subLink[i] == ',') {
              break;
            }
            link += subLink[i];
          }
          sourceUrl = 'https://www.hindustantimes.com' + link;


          //Get News Image-------------------
          var newsImage = doc.children[i]
              .getElementsByTagName('figure')[0]
              .children[0]
              .getElementsByTagName('a')[0]
              .getElementsByTagName('img')
              .where((element) => element.attributes.containsKey('src'))
              .map((e) => e.attributes['src']);

          finalNewsImage = newsImage.toString();
          finalNewsImage = finalNewsImage.replaceAll('(', '');
          finalNewsImage = finalNewsImage.replaceAll(')', '');

          //Get Headline
          var newsHeadLine = doc.children[i].getElementsByTagName('h3')[0];


          if (link.isNotEmpty) {
            hindustanTimes.add(NewsListModel(
                listItemImageUrl: finalNewsImage,
                listItemHeadLine: newsHeadLine.text.toString(),
                listItemNewsLink: sourceUrl,
                isBanner: false,
                date: DateTime.now().toString(),
                source: 'Hindustan Times'));
          }
        }
        //Return The NewsModelList
      } catch (e) {
        print('ERROR IN FETCHING DATA');
      }
    } else {
      print('Could Not connect to the URL');
    }
  }

  Future<void> extractFromBeebom() async {
    var sourceUrl = 'https://beebom.com/category/news/';
    final response = await http.Client().get(Uri.parse(sourceUrl));
    if (response.statusCode == 200) {
      var doc = parser.parse(response.body).getElementsByClassName(
          'wpnbha show-image image-alignleft ts-3 is-2 is-landscape')[0];
      try {
        for (int i = 0; i < 12; i++) {
          //Get News Link------------------
          if (i == 0 || i == 1) {
            continue;
          }
          var newsLink = doc.children[i]
              .getElementsByClassName('entry-wrapper')[0]
              .children[0]
              .getElementsByTagName('a')
              .where((element) => element.attributes.containsKey('href'))
              .map((e) => e.attributes['href']);
          var link = newsLink.toString().replaceAll('(', '');
          link = link.replaceAll(')', '');

          //Get News Image-------------------
          var newsImage = doc.children[i]
              .getElementsByTagName('figure')[0]
              .children[0]
              .getElementsByTagName('img')
              .where((element) => element.attributes.containsKey('src'))
              .map((e) => e.attributes['src']);

          var finalNewsImage = newsImage.toString();
          finalNewsImage = finalNewsImage.replaceAll('(', '');
          finalNewsImage = finalNewsImage.replaceAll(')', '');
          // Get Headline
          var newsHeadLine = doc.children[i]
              .getElementsByClassName('entry-wrapper')[0]
              .children[0]
              .children[0];

          if (link.isNotEmpty) {
            beebom.add(NewsListModel(
                listItemImageUrl: finalNewsImage,
                listItemHeadLine: newsHeadLine.text.toString(),
                listItemNewsLink: link,
                isBanner: false,
                date: DateTime.now().toString(),
                source: 'Beebom'));
          }
        }
      } catch (e) {
        print('ERROR IN FETCHING DATA');
      }
    } else {
      print('Could Not connect to the URL');
    }
  }

  Future<void> extractFromBollywoodHungama() async {
    var finalNewsImage;
    var sourceUrl = 'https://www.bollywoodhungama.com/features/';
    final response = await http.Client().get(Uri.parse(sourceUrl));
    if (response.statusCode == 200) {
      var doc = parser
          .parse(response.body)
          .getElementsByClassName('bh-cm-boxes bh-box-articles clearfix')[0];
      try {
        for (int i = 0; i < 12; i++) {
          //Get News Link------------------
          var newsLink = doc.children[i].children[1]
              .getElementsByTagName('a')
              .where((element) => element.attributes.containsKey('href'))
              .map((e) => e.attributes['href']);
          var link = newsLink.toString().replaceAll('(', '');
          link = link.replaceAll(')', '');

          //Get News Image-------------------
          var newsImage = doc.children[i].children[0].children[0]
              .getElementsByTagName('img')
              .where((element) => element.attributes.containsKey('src'))
              .map((e) => e.attributes['src']);
          finalNewsImage = newsImage.toString();
          finalNewsImage = finalNewsImage.replaceAll('(', '');
          finalNewsImage = finalNewsImage.replaceAll(')', '');
          //Get Headline
          var newsHeadLine = doc.children[i].children[1];
          if (link.isNotEmpty) {
            bollywoodHungama.add(NewsListModel(
                listItemImageUrl: finalNewsImage,
                listItemHeadLine: newsHeadLine.text.toString(),
                listItemNewsLink: link,
                isBanner: false,
                date: DateTime.now().toString(),
                source: 'Bollywood Hungama'));
          }
        }
      } catch (e) {
        print('ERROR IN FETCHING DATA');
      }
    } else {
      print('Could Not connect to the URL');
    }
  }

  Future<void> extractFromFirstpost() async {
    final url = Uri.parse('https://www.firstpost.com/category/sports');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      try {
        dom.Document document = parser.parse(response.body);

        final element=document.getElementsByClassName('main-container')[0].getElementsByClassName('main-content')[0].getElementsByClassName('big-thumb');
        List<String?> imageUrl=element.map((element) => element.getElementsByTagName('img')[0].attributes['data-src']).toList();
        List<String?> newsHeadLine=element.map((element) => element.getElementsByTagName('img')[0].attributes['title']).toList();
        List<String?> newsLink=element.map((element) => element.getElementsByTagName('a')[0].attributes['href']).toList();


        for (int i = 0; i < newsHeadLine.length; i++) {
          firstPost.add(NewsListModel(
              listItemImageUrl: 'https:' + imageUrl[i]!,
              listItemHeadLine: newsHeadLine[i]!,
              listItemNewsLink: newsLink[i]!,
              isBanner: false,
              date: DateTime.now().toString(),
              source: "Firstpost"));
        }

      } catch (error) {
        print("Error Getting Data");
      }
    }else{
      print("Error Connecting to the URL");
    }
  }

  Future<void> extractFromABPLive() async {
    final url = Uri.parse('https://news.abplive.com/news/india');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      try {
        dom.Document document = parser.parse(response.body);
        final element = document.getElementsByClassName('other_news');

        List<String?> newsLink = element
            .map((element) =>
        element.getElementsByTagName('a')[0].attributes['href'])
            .toList();
        List<String?> newsHeadLine = element
            .map((element) =>
        element.getElementsByTagName('a')[0].attributes['title'])
            .toList();
        List<String?> imageUrl = element
            .map((element) =>
        element
            .getElementsByClassName('img4x3')[0]
            .getElementsByTagName('img')[0]
            .attributes['data-src'])
            .toList();

        for (int i = 0; i < newsHeadLine.length; i++) {
          abpLive.add(NewsListModel(
              listItemImageUrl: imageUrl[i]!,
              listItemHeadLine: newsHeadLine[i]!,
              listItemNewsLink: newsLink[i]!,
              isBanner: false,
              date: DateTime.now().toString(),
              source: "ABP Live"));
        }

      } catch (error) {
        print("Error Getting Data");
        //throw error;
      }
    }else{
      print("Error Connecting to the URL");
    }
  }

  getLatestNews() async {

    clearNews();
    await extractFromIndiaToday();
    await extractFromTheEconomicTimes();
    await extractFromNDTV();
    await extractFromHindustanTimes();
    await extractFromBeebom();
    await extractFromBollywoodHungama();
    await extractFromABPLive();
      await extractFromFirstpost();
    latestNews = theEconomicTimes + indiaToday + ndtv + hindustanTimes + beebom + bollywoodHungama + firstPost + abpLive ;
    latestNews.shuffle();

  }

   clearNews(){
    theEconomicTimes.clear();
    indiaToday.clear();
    ndtv.clear();
    hindustanTimes.clear();
    beebom.clear();
    bollywoodHungama.clear();
    abpLive.clear();
    firstPost.clear();
  }
}
