import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marps_frontend/blocs/bloc/curiosity_bloc.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:marps_frontend/repositories/curiosity_repository.dart';
import 'package:marps_frontend/repositories/curiosity_repository_impl.dart';
import 'package:marps_frontend/ui/curiosity_camera_detail_page.dart';

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
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(photoList[index].rover!.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Image.network(
                      photoList[index].imgSrc!,
                      width: 300.0,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: Text(photoList[index].earthDate!),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CuriosityCameraDetailPage(
                                  cameraName: photoList[index].camera!.name!)),
                        );
                      },
                      child: const Text(
                        "View Camera Detail",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 0, 101, 183),
                          fontSize: 16,
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
