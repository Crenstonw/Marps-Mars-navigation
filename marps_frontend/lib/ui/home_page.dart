import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marps_frontend/blocs/bloc/curiosity_bloc.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:marps_frontend/repositories/curiosity_repository.dart';
import 'package:marps_frontend/repositories/curiosity_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      photoList[index].imgSrc!,
                      width: 200.0,
                    ),
                    Text(photoList[index].earthDate!),
                  ],
                )));
      },
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      itemCount: photoList.length,
    );
  }
}
