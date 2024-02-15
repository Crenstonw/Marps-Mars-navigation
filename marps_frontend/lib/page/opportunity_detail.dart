import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marps_frontend/blocs/opportunity_bloc/opportunity_bloc_bloc.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_repository.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_repository_impl.dart';

class OpportunityDetail extends StatefulWidget {
  final String camera;
  const OpportunityDetail({super.key, required this.camera});

  @override
  State<OpportunityDetail> createState() => _OpportunityDetailState();
}

class _OpportunityDetailState extends State<OpportunityDetail> {
  late OpportunityRepository opportunityRepository;

  @override
  void initState() {
    super.initState();
    opportunityRepository = OpportunityRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OpportunityBloc(opportunityRepository)
          ..add(OpportunityFetchList(widget.camera)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Opportunity\'s photos'),
            actions: [
              IconButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  icon: const Icon(Icons.filter_list))
            ],
          ),
          body: _opportunityPhotosList(),
        ));
  }

  Widget _opportunityPhotosList() {
    return BlocBuilder<OpportunityBloc, OpportunityBlocState>(
      builder: (context, state) {
        if (state is OpportunityFetchSuccess) {
          return ListView.builder(
            itemCount: state.photoList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Text(state.photoList[index].camera!.fullName!,
                        style: const TextStyle(fontSize: 24)),
                    Image.network(
                      state.photoList[index].imgSrc!,
                      width: 400,
                    )
                  ],
                ),
              );
            },
          );
        } else if (state is OpportunityFetchError) {
          return Text(state.errorMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Popular'),
                  onTap: () {
                    BlocProvider.of<OpportunityBloc>(context)
                        .add(OpportunityFetchList(widget.camera));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Top rated'),
                  onTap: () {
                    BlocProvider.of<OpportunityBloc>(context)
                        .add(OpportunityFetchList(widget.camera));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Latest'),
                  onTap: () {
                    BlocProvider.of<OpportunityBloc>(context)
                        .add(OpportunityFetchList(widget.camera));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
