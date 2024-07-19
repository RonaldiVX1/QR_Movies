import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_coding_scbd/movie_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 28),
        child: Obx(() {
          if (movieController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: movieController.movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://image.tmdb.org/t/p/w500/${movieController.movies[index].posterPath}"),
                  ),
                  title: Text(movieController.movies[index].title!),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('QR Code'),
                              content: SingleChildScrollView(
                                child: Center(
                                  child: Container(
                                    height: 120,
                                    width: 150,
                                    child: QrImageView(
                                      data:
                                          movieController.movies[index].title!,
                                      embeddedImageStyle: QrEmbeddedImageStyle(
                                        size: Size(
                                          10,
                                          10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Approve'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
