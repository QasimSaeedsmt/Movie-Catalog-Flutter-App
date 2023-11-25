import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:nextion/data/repositories/movie_service.dart';
import 'package:nextion/presentation/constants/constants_resources.dart';
import 'package:nextion/presentation/screens/list_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/movie_model.dart';
import 'domain/bloc/favourite_bloc.dart';
import 'domain/respository/movie_repository.dart';

void main() async {
  final GetIt getIt = GetIt.instance;
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>(ConstantsResources.BOX_NAME);
  await dotenv.load(fileName: ConstantsResources.ENV);
  getIt.registerSingleton<MovieRepository>(MovieService());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final GetIt getIt = GetIt.instance;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FavouriteBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.deepPurple,
                  accentColor: Colors.grey.shade600,
                  backgroundColor: Colors.grey.shade500)),
          home: ListScreen(),
        ));
  }

  @override
  void initState() {
    final getIt = GetIt.instance;
    getIt<MovieRepository>().getMovies();
    super.initState();
  }
}
