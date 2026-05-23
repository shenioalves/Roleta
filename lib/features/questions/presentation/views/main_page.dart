import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../viewmodels/question_store.dart';
import 'admin_view.dart';
import 'roulette_view.dart';

class MainPage extends StatelessWidget {
  final QuestionStore store;

  const MainPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ROLETA TITANICA',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          centerTitle: true,
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.primary,
          elevation: 4,
          shadowColor: Colors.black45,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.casino), text: 'ROLETA'),
              Tab(icon: Icon(Icons.settings), text: 'ADMIN'),
            ],
            indicatorColor: AppColors.primary,
            indicatorWeight: 4,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.white60,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
              image: NetworkImage(
                'https://www.transparenttextures.com/patterns/cubes.png',
              ),
              opacity: 0.5,
            ),
          ),
          child: TabBarView(
            children: [
              RouletteView(store: store),
              AdminView(store: store),
            ],
          ),
        ),
      ),
    );
  }
}
