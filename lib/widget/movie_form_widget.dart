import 'package:flutter/material.dart';

class MovieFormWidget extends StatelessWidget {
  final String? movieName;
  final String? dirName;
  final ValueChanged<String> onChangedMovieName;
  final ValueChanged<String> onChangedDirName;

  const MovieFormWidget({
    Key? key,
    this.movieName = '',
    this.dirName = '',
    required this.onChangedMovieName,
    required this.onChangedDirName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              buildMovieName(),
              SizedBox(height: 8),
              buildDirName(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildMovieName() => TextFormField(
        maxLines: 1,
        initialValue: movieName,
        style: TextStyle(
          color: Colors.greenAccent.shade200,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'What movie did you watch ?',
          hintStyle: TextStyle(color: Colors.greenAccent.shade200),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Movie Name cannot be empty'
            : null,
        onFieldSubmitted: onChangedMovieName,
      );

  Widget buildDirName() => TextFormField(
        maxLines: 1,
        initialValue: dirName,
        style: TextStyle(color: Colors.greenAccent.shade100, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Who was it made by ?',
          hintStyle: TextStyle(color: Colors.greenAccent.shade100),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The Director Name cannot be empty'
            : null,
        onFieldSubmitted: onChangedDirName,
      );
}
