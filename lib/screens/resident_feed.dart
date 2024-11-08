import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/main_feed.dart';

class ResidentFeed extends StatefulWidget {
  const ResidentFeed({Key? key}) : super(key: key);

  @override
  _ResidentFeedState createState() => _ResidentFeedState();
}

class _ResidentFeedState extends State<ResidentFeed> {
  final ScrollController _scrollController = ScrollController();
  double _logoHeight = 150;
  final double _maxLogoHeight = 150;
  final double _minLogoHeight = 50;
  final double _shrinkDistance = 200;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    setState(() {
      _logoHeight = _maxLogoHeight -
          (offset / _shrinkDistance) * (_maxLogoHeight - _minLogoHeight);
      _logoHeight = max(_minLogoHeight, min(_maxLogoHeight, _logoHeight));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_logoHeight),
        child: AppBar(
          backgroundColor: Colors.black,
          flexibleSpace: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              height: _logoHeight,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      drawer: const CustomNavigationDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: MainFeed(showSidebarContent: constraints.maxWidth > 600),
              ),
            ],
          );
        },
      ),
    );
  }
}
