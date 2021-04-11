import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pemrograman_mobile_week9/models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  MovieDetail(this.movie);
  @override
  Widget build(BuildContext context) {
    String path;
    String backdrop;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
      backdrop = imgPath + movie.backdropPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF151C26),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color(0xFF151C26)),
        backgroundColor: Color(0xFF151C26),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: Text(
                movie.title,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10),
                    height: height / 2.2,
                    child: Image.network(path)),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 118),
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              bottom: 10, top: 10, left: 10, right: 10),
                          color: Colors.grey.withOpacity(0.6),
                          height: 40,
                          width: 70,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                              Text(movie.voteAverage.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 250, left: 145),
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              bottom: 10, top: 10, left: 10, right: 10),
                          color: Colors.amber[700],
                          height: 40,
                          width: 125,
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              Text("105 Minutes",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("1h 45m",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 20)),
                      ),
                      Container(
                        child: Text(" Action / Mystery",
                            style: TextStyle(
                                color: Colors.amber[700], fontSize: 13)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 13),
                                color: Colors.grey[800].withOpacity(0.6),
                                height: 40,
                                width: 150,
                                child: Row(
                                  children: [
                                    Text(
                                        movie.voteAverage.toString() +
                                            "/10 Vote Average",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 13),
                                color: Colors.grey[800].withOpacity(0.6),
                                height: 40,
                                width: 150,
                                child: Row(
                                  children: [
                                    Text(
                                        movie.voteCount.toString() +
                                            " Vote Count",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
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
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: Text(
                "Overview",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: Text(
                  "\t\t\t\t\t\t" +
                      movie.overview +
                      "\n" +
                      "\t\t\t\t\t\t" +
                      movie.overview +
                      "\n" +
                      "\t\t\t\t\t\t" +
                      movie.overview,
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: Text(
                "Backdrop",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: 40, top: 5, right: 10, bottom: 10),
                child: Image.network(backdrop)),
          ],
        ),
      )),
    );
  }
}
