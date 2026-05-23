import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'admin_view.dart';
import 'roulette_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                'https://www.transparenttextures.com/patterns/cubes.png',
              ),
              opacity: 0.5,
            ),
          ),
          child: const TabBarView(
            children: [
              RouletteView(),
              AdminView(),
            ],
          ),
        ),
      ),
    );
  }
}
