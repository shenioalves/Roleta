import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'core/theme/app_colors.dart';
import 'features/questions/data/repositories/question_repository.dart';
import 'features/questions/presentation/viewmodels/question_store.dart';
import 'features/questions/presentation/views/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Setup Repository
  final repository = QuestionRepositoryImpl();
  await repository.init();
  
  // Setup Store
  final store = QuestionStore(repository);
  
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final QuestionStore store;

  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TITAN Roleta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: MainPage(store: store),
    );
  }
}
