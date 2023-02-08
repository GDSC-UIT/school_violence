import 'package:flutter/material.dart';

class TestTabViewPage extends StatefulWidget {
  const TestTabViewPage({super.key});

  @override
  State<TestTabViewPage> createState() => _TestTabViewPageState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TestTabViewPageState extends State<TestTabViewPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Widget'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Text('Hi'),
                  Text('Bro'),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Text('Hi Gà'),
                  Text('Hi Bê'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
