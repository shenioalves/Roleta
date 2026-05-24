import 'package:get_it/get_it.dart';

import '../../features/questions/data/repositories/question_repository.dart';
import '../../features/questions/presentation/viewmodels/question_store.dart';
import '../services/audio_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  final audioService = AudioService();
  await audioService.init();
  locator.registerSingleton<AudioService>(audioService);

  // Repositories
  final questionRepository = QuestionRepositoryImpl();
  await questionRepository.init();
  locator.registerLazySingleton<QuestionRepository>(() => questionRepository);

  // Stores
  final questionStore = QuestionStore(locator<QuestionRepository>(), locator<AudioService>());
  await questionStore.init();
  locator.registerSingleton<QuestionStore>(questionStore);
}
