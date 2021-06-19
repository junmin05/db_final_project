import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Drawer 관련 Key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ///* ----------------- BottomNavigationBar, PageView 관련 ----------------- *///
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ///* -------------------------------------------------------------------- *///

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(context),
        drawer: buildDrawer(context),
        body: Container(
          color: Colors.cyan,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: SizedBox.expand(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  // NavBar Index 별 상응 위젯 출력
                  children: _buildWidgetOptions(context),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: buildNavBar(context),
        floatingActionButton: buildFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
    //);
  }

  /// Index 별 위젯 반환: (순서: 0-Give, 1-Take, 2-Chart, 3-MyPage)
  List<Widget> _buildWidgetOptions(BuildContext context) {
    var _widgetOptions = <Widget>[
      /// 0(Give):
      // CustomScrollView(
      //   physics: const BouncingScrollPhysics(
      //       parent: AlwaysScrollableScrollPhysics()),
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       backgroundColor: Colors.cyan,
      //       // stretch: true,
      //       pinned: false,
      //       snap: false,
      //       floating: false,
      //       expandedHeight: 120.0,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text(
      //           'Home | Give',
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontFamily: 'NanumSquareRoundR',
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         background: Stack(
      //           fit: StackFit.expand,
      //           children: <Widget>[
      //             FlutterLogo(),
      //             const DecoratedBox(
      //               decoration: BoxDecoration(
      //                 gradient: LinearGradient(
      //                   begin: Alignment(0.0, 0.5),
      //                   end: Alignment.center,
      //                   colors: <Color>[
      //                     Color(0x60000000),
      //                     Color(0x00000000),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       actions: <Widget>[
      //         IconButton(
      //           icon: Icon(
      //             Icons.location_on,
      //             semanticLabel: 'location',
      //           ),
      //           onPressed: () {
      //             Navigator.pushNamed(context, '/map');
      //           },
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
            child: Row(
              children: [
                // Expanded(
                //   child: Text(
                //     'Give | 나눔 게시판',
                //     style: TextStyle(
                //       fontFamily: 'NanumSquareRoundR',
                //       fontSize: 16.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black87,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Expanded(
          //   /// New method (listview builder 사용)
          //   child: ListView.separated(
          //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          //     itemCount: appState.giveProducts.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return PostTile(appState.giveProducts[index], _selectedIndex);
          //     },
          //     separatorBuilder: (context, index) {
          //       // if (index == 0) return SizedBox.shrink();
          //       return const Divider(
          //         height: 20,
          //         thickness: 1,
          //         indent: 8,
          //         endIndent: 8,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),

      /// 1(Take):

      /// 2(Chart) 작업중, Sliver 사용 실험중:

      /// 3(MyPage):
    ];
    return _widgetOptions;
  }

  FloatingActionButton buildFAB() {
    if (_selectedIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/giveadd');
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      );
    } else if (_selectedIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/takeadd');
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      );
    }
    return null;
  }

  /// Builder Widget for AppBar
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          'PLSF',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'NanumSquareRoundR',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.cyan,
      leading: IconButton(
        icon: Icon(
          Icons.menu_rounded,
          semanticLabel: 'menu',
        ),
        onPressed: () =>
            _scaffoldKey.currentState.openDrawer(), // Open drawer on pressed
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.location_on,
            semanticLabel: 'location',
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  /// Builder Widget for Bottom Navigation Bar
  BottomNavigationBar buildNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.cyan,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
          fontFamily: 'NanumSquareRoundR', fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
          fontFamily: 'NanumSquareRoundR', fontWeight: FontWeight.bold),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.redo),
          label: 'Teams',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.undo),
          label: 'Players',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Matches',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Stadiums',
        )
      ],
    );
  }

  /// Builder Widget for Drawer
  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '-Drawer-',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            // - The Menu Icons should be placed in the leading position
            leading: Icon(
              Icons.home,
            ),
            onTap: () {
              // - Each menu should be navigated by Named Routes
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Map'),
            leading: Icon(
              Icons.map,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/map');
            },
          ),
          ListTile(
            title: Text('My Page'),
            leading: Icon(
              Icons.account_circle,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/mypage');
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(
              Icons.settings,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
