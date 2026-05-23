import 'package:get_it/get_it.dart';
import '../../features/questions/data/repositories/question_repository.dart';
import '../../features/questions/presentation/viewmodels/question_store.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories
  final questionRepository = QuestionRepositoryImpl();
  await questionRepository.init();
  sl.registerLazySingleton<QuestionRepository>(() => questionRepository);

  // Stores
  sl.registerFactory(() => QuestionStore(sl<QuestionRepository>()));
}
