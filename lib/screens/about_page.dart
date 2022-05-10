import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      title: const Text('C R Y P T O N I T E'),
      stretchMaxHeight: 0.50,
      headerWidget: headerWidget(context),
      body: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            // color: Colors.white,
            height: 250,
            child: Image(image: AssetImage('assets/media/about.png')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: const [
              Text(
                'Credits',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Data provided by CoinGeckoAPI'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'For bugs and issues:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text('Please contact the author: "Marraviglioso" on Github')
            ],
          ),
        ),
      ],
      drawer: SafeArea(
        child: Drawer(
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
                  Navigator.pushReplacementNamed(context, '/about');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Align(
              child: Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
