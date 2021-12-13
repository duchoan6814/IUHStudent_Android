import  'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/queries/queries.dart';
import 'package:iuh_student/screens/screens.dart';
import 'package:iuh_student/storage/context.dart';
import 'package:iuh_student/utils/global_storage.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function handleDeleteToken = () async {
      await GlobalStorage.deleteToken();
    };

    return Query(
      options: QueryOptions(
        document: gql(getProfileQuery),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          handleDeleteToken();
          return LoginPage();
        }

        currentStudent = result.data?["getProfile"]?["data"];
        return MainScreeen();
      },
    );
  }
}
