import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/queries/queries.dart';
import 'package:iuh_student/storage/context.dart';
import 'package:iuh_student/utils/global_storage.dart';
import 'screens.dart';

class MainScreeen extends StatefulWidget {
  const MainScreeen({Key? key}) : super(key: key);

  @override
  _MainScreeenState createState() => _MainScreeenState();
}

class _MainScreeenState extends State<MainScreeen> {
  int currentScreen = 0;

  final screens = [
    HomeScreen(),
    ScheduleScreen(),
    ResultScreen(),
    RegisterObjectScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    Function handleDeleteStorage = () async {
      await GlobalStorage.deleteToken();
    };

    return Query(
      options: QueryOptions(
        document: gql(getProfileQuery),
        pollInterval: Duration(seconds: 10),

      ),
      builder: (QueryResult result,
          { VoidCallback? refetch, FetchMore? fetchMore }) {
        if (result.hasException) {
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            handleDeleteStorage();
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          });
        }

        print(result.data?["getProfile"]?["data"]);
        currentStudent = result.data?["getProfile"]?["data"];
        return Scaffold(
          body: SafeArea(child: screens[currentScreen]),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) =>
                setState(() {
                  currentScreen = index;
                }),
            currentIndex: currentScreen,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: "Lịch học"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.stacked_bar_chart),
                  label: "Kết quả"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.app_registration),
                  label: "DKHP"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile"
              ),
            ],
          ),
        );;
      },
    );
  }
}
