import 'package:flutter/material.dart';
import 'package:yellow_class_assignment/components/DBHelper.dart';
import 'package:yellow_class_assignment/components/movieInfo.dart';
import 'package:yellow_class_assignment/widget/movie_form_widget.dart';

class AddEditMoviePage extends StatefulWidget {
  final MovieInfo? movie;

  const AddEditMoviePage({
    Key? key,
    this.movie,
  }) : super(key: key);
  @override
  _AddEditMoviePage createState() => _AddEditMoviePage();
}

class _AddEditMoviePage extends State<AddEditMoviePage> {
  final _formKey = GlobalKey<FormState>();
  late String movieName;
  late String dirName;
  late String photoName;

  @override
  void initState() {
    movieName = widget.movie?.movieName ?? '';
    dirName = widget.movie?.dirName ?? '';
    photoName = widget.movie?.photoName ??
        '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';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MovieFormWidget(
                      movieName: movieName,
                      dirName: dirName,
                      photoName: photoName,
                      onChangedPhotoName: (photoName) =>
                          setState(() => this.photoName = photoName),
                      onChangedMovieName: (movieName) =>
                          setState(() => this.movieName = movieName),
                      onChangedDirName: (dirName) =>
                          setState(() => this.dirName = dirName),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = movieName.isNotEmpty && dirName.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: isFormValid ? Colors.black : Colors.grey,
          onSurface: Colors.transparent,
          primary: isFormValid ? Colors.greenAccent : Colors.transparent,
        ),
        onPressed: isFormValid ? addOrUpdateNote : () {},
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateMovie();
      } else {
        await addMovie();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      movieName: movieName,
      dirName: dirName,
      photoName: photoName,
    );

    await DBHelper.instance.update(movie);
  }

  Future addMovie() async {
    final movie = MovieInfo(
      movieName: movieName,
      dirName: dirName,
      photoName: photoName,
    );

    await DBHelper.instance.insertMovie(movie);
  }
}
