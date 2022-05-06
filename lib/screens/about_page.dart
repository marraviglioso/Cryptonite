import 'package:flutter/material.dart';


class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/media/menu.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bug_report_rounded,
              ),
              title: const Text('Report bugs'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text('C R Y P T O N I T E'),
            backgroundColor: Colors.deepPurple,
            floating: false,
            pinned: false,
            centerTitle: true,
            expandedHeight: 90,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.deepPurple,
              height: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 250,
                child: Image(image: AssetImage('assets/media/about.png')),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Data provided by CoinGeckoAPI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'For bugs and issues:',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Text('Please contact the author: "Marraviglioso" on Github')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
