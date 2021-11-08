import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/queries/queries.dart';
import 'package:iuh_student/utils/global_storage.dart';
import 'screens/screens.dart';

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleDeleteStorage() async {
      await GlobalStorage.deleteToken();
    }

    final HttpLink httpLink = HttpLink(
      'http://18.136.126.228/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${await GlobalStorage.getToken() ?? ""}',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          title: 'IUH Student',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Query(
            options: QueryOptions(
              document: gql(getProfileQuery),
              pollInterval: Duration(seconds: 10),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                handleDeleteStorage();
                return LoginPage();
              }
              return MainScreeen();
            },
          )),
    );
  }
}
