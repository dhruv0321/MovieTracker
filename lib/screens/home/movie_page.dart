import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:yellow_class_assignment/components/DBHelper.dart';
import 'package:yellow_class_assignment/components/google_sign_in.dart';
import 'package:yellow_class_assignment/components/imageUtil.dart';
import 'package:yellow_class_assignment/components/movieInfo.dart';
import 'package:yellow_class_assignment/screens/home/edit_movie_page.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final user = FirebaseAuth.instance.currentUser!;
  late List<MovieInfo> movies;
  bool isLoading = false;

  @override
  void initState() {
    refreshMovies();
    super.initState();
  }

  @override
  void dispose() {
    DBHelper.instance.close();
    super.dispose();
  }

  Future refreshMovies() async {
    setState(() => isLoading = true);

    this.movies = await DBHelper.instance.getMovies();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.greenAccent),
              )),
        ],
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              user.displayName!,
              style: TextStyle(
                  color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : movies.isEmpty
                  ? Text(
                      'No Movies',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    )
                  : buildCards(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          hoverColor: Colors.greenAccent,
          focusColor: Colors.greenAccent,
          splashColor: Colors.greenAccent,
          elevation: 10,
          child: Icon(
            Icons.add,
            //color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditMoviePage()),
            );
            refreshMovies();
          }),
    );
  }

  Widget editButton(MovieInfo movie) => IconButton(
      icon: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.edit_outlined,
          size: 25,
          color: Colors.black,
        ),
      ),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditMoviePage(movie: movie),
        ));
        refreshMovies();
      });

  Widget deleteButton(MovieInfo movie) => IconButton(
        icon: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          await DBHelper.instance.delete(movie.id);
          refreshMovies();
        },
      );

  Widget buildCards() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(5),
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Card(
          color: Colors.transparent,
          shadowColor: Colors.greenAccent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 4.0,
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            front: buildFront(movie),
            back: buildBack(movie),
          ),
        );
      },
    );
  }

  Widget buildBack(MovieInfo movie) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Utility.imageFromBase64String2(movie.photoName),
          ),
          Column(
            children: [
              editButton(movie),
              deleteButton(movie),
            ],
          ),
        ],
      ),
    );
  }

  Container buildFront(MovieInfo movie) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Utility.imageFromBase64String(movie.photoName),
          ),
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
              child: movieDetails(movie)),
        ],
      ),
    );
  }

  Widget movieDetails(MovieInfo movie) {
    return ListTile(
      title: Text(
        movie.movieName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        movie.dirName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
