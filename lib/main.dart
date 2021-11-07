import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iuh_student/queries/queries.dart';
import 'screens/screens.dart';

void main() async {
  await initHiveForFlutter();

  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: "__access__token__");

  final HttpLink httpLink = HttpLink(
    'http://18.136.126.228/graphql',
    defaultHeaders: token != null ? <String, String> {
      "Authorization": "Bearer ${token}"
    } : <String, String> {
      "Authorization": "Bearer "
    }
  );

  final Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MyApp(client: client,));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({Key? key, required this.client}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    // Create storage
    final storage = new FlutterSecureStorage();

    Function handleDeleteStorage = () async {
      await storage.delete(key: "__access__token__");
    };

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'IUH Student',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
            child: Query(
              options: QueryOptions(
                document: gql(getProfileQuery),
                pollInterval: Duration(seconds: 10),

              ),
                builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                  if(result.hasException) {
                    handleDeleteStorage();
                    return LoginPage();
                  }

                  return MainScreeen();
                },

            )
        ),
      ),
    );
  }
}
