import 'dart:convert';
import 'dart:async';
import 'package:cryptonite/models/coin.dart';
import 'package:cryptonite/widgets/design/coin_card_design.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool isdataLoaded = false;
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty && mounted) {
        setState(() {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              coinList.add(Coin.fromJson(map));
            }
          }
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning ✨';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon 😎';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening 🌙';
    } else {
      return 'Good Night 🌝';
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 20), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    () async {
      if (isDialOpen.value) {
        isDialOpen.value = false;
        return false;
      } else {
        return true;
      }
    };
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      title: const Text('C R Y P T O N I T E'),
      stretchMaxHeight: 0.50,
      headerWidget: headerWidget(context),
      body: [
        listView(),
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
                  Navigator.pop(
                    context,
                  );
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
      fullyStretchable: false,
      backgroundColor: Colors.white,
      appBarColor: Colors.deepPurple,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        openCloseDial: isDialOpen,
        backgroundColor: Colors.deepPurple,
        overlayColor: Colors.deepPurple[200],
        overlayOpacity: 0.6,
        spacing: 8,
        spaceBetweenChildren: 10,
        closeManually: false,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.percent_rounded),
              label: 'Sort by percentage',
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              onTap: () {
                setState(() {
                  coinList.sort((a, b) =>
                      b.changePercentage.compareTo(a.changePercentage));
                });
              }),
          SpeedDialChild(
              child: const Icon(Icons.price_change_outlined),
              label: 'Sort by price',
              onTap: () {
                setState(() {
                  coinList.sort((a, b) => b.price.compareTo(a.price));
                });
              }),
          SpeedDialChild(
              child: const Icon(Icons.format_color_text_rounded),
              label: 'Sort by name',
              onTap: () {
                setState(() {
                  coinList.sort((a, b) => b.name.compareTo(a.name));
                });
              }),
        ],
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: coinList.length,
      itemBuilder: (context, index) {
        return CoinCardDesign(
          name: coinList[index].name,
          symbol: coinList[index].symbol,
          imageUrl: coinList[index].imageUrl,
          price: coinList[index].price.toDouble(),
          change: coinList[index].change.toDouble(),
          changePercentage: coinList[index].changePercentage.toDouble(),
        );
      },
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              child: Text(
                greetingMessage(),
                style: const TextStyle(color: Colors.white, fontSize: 38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// TODO: Need new cards inside headerWidgets, maybe nft page