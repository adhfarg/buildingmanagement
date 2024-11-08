import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/main_feed.dart';
import '../widgets/right_sidebar.dart';

class ResidentFeed extends StatelessWidget {
  const ResidentFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 150,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 160,
      ),
      drawer: const CustomNavigationDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 3,
                  child: MainFeed(showSidebarContent: false),
                ),
                SizedBox(
                  width: 300,
                  child: RightSidebar(),
                ),
              ],
            );
          } else {
            return const MainFeed(showSidebarContent: true);
          }
        },
      ),
    );
  }
}
