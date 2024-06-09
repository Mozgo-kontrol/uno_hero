import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/home_page/home_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "UNO Heros",
          style: themeData.textTheme.headlineLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    bloc: BlocProvider.of<HomeBloc>(context)..add(ShowStartPageEvent()),
                    builder: (context, homeState) {
                      if (homeState is HomeStateLoading) {
                        return CircularProgressIndicator(
                          color: themeData.colorScheme.secondary,
                        );
                      } else {
                        return const Placeholder();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
