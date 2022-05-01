import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'package:cryptonite/models/coin.dart';
import 'package:cryptonite/screens/about_page.dart';
import 'package:cryptonite/widgets/design/coin_card_design.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool isdataLoaded = false;
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
      }
      count();
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  void count() {
    if (isdataLoaded = true) {
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 120), (timer) => fetchCoin());
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
    return Scaffold(
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        openCloseDial: isDialOpen,
        backgroundColor: Colors.deepPurple,
        overlayColor: Colors.white,
        overlayOpacity: 0.1,
        spacing: 5,
        spaceBetweenChildren: 5,
        closeManually: false,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.percent_rounded),
              label: 'Sort by percentage',
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CoinCardDesign(
                  name: coinList[index].name,
                  symbol: coinList[index].symbol,
                  imageUrl: coinList[index].imageUrl,
                  price: coinList[index].price.toDouble(),
                  change: coinList[index].change.toDouble(),
                  changePercentage: coinList[index].changePercentage.toDouble(),
                );
              },
              childCount: coinList.length,
            ),
          )
        ],
      ),
    );
  }
}
