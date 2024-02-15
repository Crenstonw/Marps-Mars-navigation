import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marps_frontend/blocs/opportunity_bloc/opportunity_bloc_bloc.dart';
import 'package:marps_frontend/blocs/opportunity_detail_bloc/opportunity_detail_bloc_bloc.dart';
import 'package:marps_frontend/page/opportunity_detail.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_detail_repository.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_detail_repository_impl.dart';

class OpportunityPage extends StatefulWidget {
  const OpportunityPage({super.key});

  @override
  State<OpportunityPage> createState() => _OpportunityPageState();
}

class _OpportunityPageState extends State<OpportunityPage> {
  late OpportunityDetailRepository opportunityRepository;

  @override
  void initState() {
    super.initState();
    opportunityRepository = OpportunityDetailRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OpportunityDetailBlocBloc(opportunityRepository),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Opportunity\'s Cameras'),
            actions: [
              IconButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  icon: const Icon(Icons.filter_list))
            ],
          ),
          body: _opportunityCamerasList(),
        ));
  }

  Widget _opportunityCamerasList() {
    return BlocBuilder<OpportunityDetailBlocBloc, OpportunityDetailBlocState>(
      builder: (context, state) {
        if (state is OpportunityDetailFetchSuccess) {
          return ListView.builder(
            itemCount: state.cameraList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Text(state.cameraList[index].fullName!,
                        style: const TextStyle(fontSize: 24)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OpportunityDetail(camera: state.cameraList[index].name!.toString())
                          ),
                        );
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              );
            },
          );
        } else if (state is OpportunityDetailFetchError) {
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
                    BlocProvider.of<OpportunityBloc>(context);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Top rated'),
                  onTap: () {
                    BlocProvider.of<OpportunityBloc>(context);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Latest'),
                  onTap: () {
                    BlocProvider.of<OpportunityBloc>(context);
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
