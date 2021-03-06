import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pemrograman_mobile_week9/service/httpservice.dart';

import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount;
  List movies;
  List topMovies;
  int topCount;
  List upcomingMovies;
  int upcomingCount;
  HttpService service;
  String imgPath = 'https://image.tmdb.org/t/p/w500/';

  List<String> imgList = [];

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    topMovies = [];
    topMovies = await service.getTopMovies();
    upcomingMovies = [];
    upcomingMovies = await service.getUpcomingMovies();
    setState(() {
      moviesCount = movies.length;
      topCount = topMovies.length;
      upcomingCount = upcomingMovies.length;
      movies = movies;
      topMovies = topMovies;
      upcomingMovies = upcomingMovies;
      for (int i = 0; i < 3; i++) {
        String image = imgPath + movies[i].posterPath;
        imgList.add(image);
      }
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF151C26),
          appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Color(0xFF151C26)),
            backgroundColor: Color(0xFF151C26),
            brightness: Brightness.dark,
            title: Row(
              children: [
                Container(
                  child: Text(
                    "Movie",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Container(
                  child: Text("HD",
                      style: TextStyle(
                          color: Colors.amber[700],
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text("Trending",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
                Container(
                    child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: imgList
                          .map((item) => Container(
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            Image.network(item,
                                                fit: BoxFit.cover,
                                                width: 1000.0),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          200, 0, 0, 0),
                                                      Color.fromARGB(0, 0, 0, 0)
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      movies[imgList
                                                              .indexOf(item)]
                                                          .title,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        Text(
                                                          movies[imgList
                                                                  .indexOf(
                                                                      item)]
                                                              .voteAverage
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  onTap: () {
                                    MaterialPageRoute route = MaterialPageRoute(
                                        builder: (_) => MovieDetail(
                                            movies[imgList.indexOf(item)]));
                                    Navigator.push(context, route);
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                )),
                TabBar(
                  indicatorColor: Colors.amber[700],
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.amber[700],
                  tabs: [
                    new Container(
                      child: new Tab(text: 'Popular'),
                    ),
                    new Container(
                      child: new Tab(text: 'Top Rated'),
                    ),
                    new Container(
                      child: new Tab(text: 'Upcoming'),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // first tab bar view widget
                      Popular(movies, moviesCount),

                      // second tab bar viiew widget
                      TopRated(topMovies, topCount),
                      Upcoming(upcomingMovies, upcomingCount),
                    ],
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

class Popular extends StatelessWidget {
  int moviesCount;
  List movies;
  Popular(this.movies, this.moviesCount);
  String imgPath = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          itemBuilder: (context, int position) {
            return Card(
              elevation: 0.0,
              color: Color(0xFF151C26),
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Image.network(
                        imgPath + movies[position].posterPath,
                        width: 100,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 120, top: 10),
                        child: Text(
                            movies[position].title +
                                "\n" +
                                "(" +
                                movies[position].releaseDate.substring(0, 4) +
                                ")",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 120, top: 70),
                        child: Text(
                            movies[position].overview.substring(0, 80) + "...",
                            style: TextStyle(
                                color: Colors.amber[700], fontSize: 10)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 110, left: 70),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: 10, top: 10, left: 10, right: 10),
                                color: Colors.amber[700],
                                height: 40,
                                width: 70,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Text(
                                        movies[position].voteAverage.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          }),
    );
  }
}

class TopRated extends StatelessWidget {
  List topMovies;
  int topCount;
  TopRated(this.topMovies, this.topCount);
  String imgPath = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: (this.topCount == null) ? 0 : this.topCount,
          itemBuilder: (context, int position) {
            return Card(
              elevation: 0.0,
              color: Color(0xFF151C26),
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Image.network(
                        imgPath + topMovies[position].posterPath,
                        width: 100,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 120, top: 10),
                        child: Text(
                            topMovies[position].title +
                                "\n" +
                                "(" +
                                topMovies[position]
                                    .releaseDate
                                    .substring(0, 4) +
                                ")",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 120, top: 70),
                        child: Text(
                            topMovies[position].overview.substring(0, 80) +
                                "...",
                            style: TextStyle(
                                color: Colors.amber[700], fontSize: 10)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 110, left: 70),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: 10, top: 10, left: 10, right: 10),
                                color: Colors.amber[700],
                                height: 40,
                                width: 70,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Text(
                                        topMovies[position]
                                            .voteAverage
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(topMovies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          }),
    );
  }
}

class Upcoming extends StatelessWidget {
  List upcomingMovies;
  int upcomingCount;
  Upcoming(this.upcomingMovies, this.upcomingCount);
  String imgPath = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: (this.upcomingCount == null) ? 0 : this.upcomingCount,
          itemBuilder: (context, int position) {
            return Card(
              elevation: 0.0,
              color: Color(0xFF151C26),
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Image.network(
                        imgPath + upcomingMovies[position].posterPath,
                        width: 100,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 120, top: 10),
                        child: Text(
                            upcomingMovies[position].title +
                                "\n" +
                                "(" +
                                upcomingMovies[position]
                                    .releaseDate
                                    .substring(0, 4) +
                                ")",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 120, top: 70),
                        child: Text(
                            upcomingMovies[position].overview.substring(0, 80) +
                                "...",
                            style: TextStyle(
                                color: Colors.amber[700], fontSize: 10)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 110, left: 70),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: 10, top: 10, left: 10, right: 10),
                                color: Colors.amber[700],
                                height: 40,
                                width: 70,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Text(
                                        upcomingMovies[position]
                                            .voteAverage
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(upcomingMovies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          }),
    );
  }
}
