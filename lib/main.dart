import 'package:bloc_firebase_auth/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloc_firebase_auth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloc_firebase_auth/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_firebase_auth/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_firebase_auth/features/auth/presentation/pages/register_page.dart';
import 'package:bloc_firebase_auth/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final firebaseAuth = FirebaseAuth.instance;
final remoteDataSource = AuthRemoteDataSource(firebaseAuth);

final repository = AuthRepositoryImpl(remoteDataSource);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc(repository))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
