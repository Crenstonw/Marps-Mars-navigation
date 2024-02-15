import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marps_frontend/blocs/curiosity_bloc/curiosity_bloc.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:marps_frontend/repositories/curiosity_repository.dart';
import 'package:marps_frontend/repositories/curiosity_repository_impl.dart';
import 'package:marps_frontend/page/curiosity_camera_detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class CuriosityPage extends StatefulWidget {
  const CuriosityPage({super.key});

  @override
  State<CuriosityPage> createState() => _CuriosityPageState();
}

class _CuriosityPageState extends State<CuriosityPage> {
  late CuriosityRepository curiosityRepository;

  @override
  void initState() {
    super.initState();
    curiosityRepository = CuriosityRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CuriosityBloc(curiosityRepository)
          ..add(PhotosCuriosityFetchEvent());
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nasa Rover Curiosity'),
          ),
          body: _photoView(context)),
    );
  }

  Widget _photoView(BuildContext context) {
    return BlocBuilder<CuriosityBloc, CuriosityState>(
      builder: (context, state) {
        if (state is CuriosityInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PhotoFetchError) {
          return Column(
            children: [
              Text(state.messageError),
              ElevatedButton(
                onPressed: () {
                  context
                      .watch<CuriosityBloc>()
                      .add(PhotosCuriosityFetchEvent());
                },
                child: const Text('Retry'),
              )
            ],
          );
        } else if (state is PhotoFetched) {
          return _CuriosityListView(context, state.photoList);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _CuriosityListView(BuildContext context, List<Photo> photoList) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: photoList[index].imgSrc!,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 10,
                              left: 18,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(photoList[index].rover!.name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 18,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.numbers,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  Text(photoList[index].id!.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CuriosityCameraDetailPage(
                              cameraName: photoList[index].camera!.name!,
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 46, 47, 57),
                        ),
                      ),
                      child: Text(
                        "Camera ${photoList[index].camera!.name!}",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )));
      },
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      itemCount: photoList.length,
    );
  }
}
