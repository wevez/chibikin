import 'package:chibikin/view/pages/home.dart';
import 'package:chibikin/view/router/page_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
  (ref) {
    final home = GoRoute(
      path: PagePath.home.path,
      name: PagePath.home.name,
      builder: (_, __) => const HomePage(),
    );

    return GoRouter(
      initialLocation: PagePath.home.path,
      debugLogDiagnostics: false,
      routes: [
        home,
      ],
    );
  }
);