import 'package:flutter/material.dart';
import 'package:main_project/pages/edit_member_page.dart';
import 'package:main_project/pages/home_page.dart';
import 'package:main_project/pages/login_page.dart';
import 'package:main_project/pages/members_page.dart';
import 'package:main_project/pages/new_member_page.dart';
import 'package:main_project/pages/new_task_page.dart';
import 'package:main_project/pages/register_page.dart';
import 'package:main_project/pages/edit_task_page.dart';
import 'package:go_router/go_router.dart';
import 'package:main_project/pages/tasks_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/new-task',
      name: 'newTask',
      builder: (context, state) => const NewTaskPage(),
    ),
    GoRoute(
      path: '/new-member',
      name: 'newMember',
      builder: (context, state) => const NewMemberPage(),
    ),
    GoRoute(
      path: '/tasks',
      name: 'tasks',
      builder: (context, state) => const TasksPage(),
    ),
    GoRoute(
        path: '/tasks/:taskId',
        name: 'taskEdit',
        builder: (context, state) =>
            EditTaskPage(taskId: state.pathParameters['taskId'])),
    GoRoute(
        path: '/members',
        name: 'members',
        builder: (context, state) => const MembersPage()),
    GoRoute(
        path: '/members/:memberId',
        name: 'memberEdit',
        builder: (context, state) =>
            EditMemberPage(memberId: state.pathParameters['memberId']))
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          onSecondary: Colors.grey.shade200,
          onTertiary: Colors.white,
        ),
        primaryColor: const Color.fromRGBO(65, 42, 114, 1),
        primaryColorLight: const Color.fromRGBO(234, 215, 255, 1),
        highlightColor: const Color.fromRGBO(219, 185, 255, 1),
        dialogBackgroundColor: Colors.white,
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.grey.shade300,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(65, 42, 114, 1),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          labelStyle: const TextStyle(
            color: Color.fromRGBO(65, 42, 114, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
