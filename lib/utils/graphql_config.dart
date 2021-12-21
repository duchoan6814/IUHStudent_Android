import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/utils/global_storage.dart';

final HttpLink httpLink = HttpLink(
  'http://iuhstudent-be.tk/graphql',
);

final AuthLink authLink = AuthLink(
  getToken: () async => 'Bearer ${await GlobalStorage.getToken() ?? ""}',
  // OR
  // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
);

final Link link = authLink.concat(httpLink);

GraphQLClient clientA = GraphQLClient(
  link: link,
  cache: GraphQLCache(store: HiveStore()),
);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: link,
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(store: HiveStore()),
  ),
);