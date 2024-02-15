import 'package:flutter/material.dart';
import 'package:marps_frontend/blocs/curiosity_detail_bloc/bloc/curiosity_detail_bloc.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:marps_frontend/repositories/camera_detail_repository.dart';
import 'package:marps_frontend/repositories/camera_detail_respository_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class CuriosityCameraDetailPage extends StatefulWidget {
  const CuriosityCameraDetailPage({super.key, required this.cameraName});
  final String cameraName;

  @override
  State<CuriosityCameraDetailPage> createState() =>
      _CuriosityCameraDetailPageState();
}

class _CuriosityCameraDetailPageState extends State<CuriosityCameraDetailPage> {
  late CameraDetailRepository cameraDetailRepository;

  @override
  void initState() {
    super.initState();
    cameraDetailRepository = CameraDetailRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CuriosityDetailBloc(cameraDetailRepository)
          ..add(CuriosityDetailFetchEvent(widget.cameraName));
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nasa Rover Curiosity'),
          ),
          body: _detailView(context)),
    );
  }

  Widget _detailView(BuildContext context) {
    return BlocBuilder<CuriosityDetailBloc, CuriosityDetailState>(
      builder: (context, state) {
        if (state is CuriosityDetailInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailFetchError) {
          return Column(
            children: [
              Text(state.messageError),
              ElevatedButton(
                onPressed: () {
                  context
                      .watch<CuriosityDetailBloc>()
                      .add(CuriosityDetailFetchEvent(widget.cameraName));
                },
                child: const Text('Retry'),
              )
            ],
          );
        } else if (state is DetailFetched) {
          return _CuriosityDetailListView(context, state.photoList);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _CuriosityDetailListView(BuildContext context, List<Photo> photoList) {
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
                                  Text(photoList[index].camera!.name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Color.fromARGB(
                                              255, 254, 254, 254))),
                                  const SizedBox(width: 185),
                                  if (photoList[index].rover!.status! ==
                                      "active")
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 15, 136, 37),
                                    )
                                  else
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 136, 15, 15),
                                    )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 18,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(photoList[index].camera!.fullName!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.rocket_launch,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  photoList[index].rover!.launchDate!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 88, 88, 88)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(
                                  Icons.landslide,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  photoList[index].rover!.landingDate!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 88, 88, 88)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 75),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.alarm,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  photoList[index].rover!.maxSol!.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 88, 88, 88)),
                                ),
                                const SizedBox(width: 40),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(
                                  Icons.public,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  photoList[index].earthDate!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 88, 88, 88)),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )));
      },
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      itemCount: photoList.length,
    );
  }
}
