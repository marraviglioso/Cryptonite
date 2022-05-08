import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoinCardDesign extends StatelessWidget {
  String name;
  String symbol;
  String imageUrl;
  double price;
  double change;
  double changePercentage;

  // ignore: use_key_in_widget_constructors
  CoinCardDesign({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: changePercentage.toDouble() < 0
              ? const Color.fromARGB(255, 235, 207, 228)
              : const Color.fromARGB(255, 200, 233, 220),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      // name coin
                      name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    //symbol coin
                    symbol.toUpperCase(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    //price
                    '\$' + price.toDouble().toStringAsFixed(3),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    //var price
                    change.toDouble() < 0
                        ? change.toDouble().toStringAsFixed(3)
                        : '+' + change.toDouble().toStringAsFixed(3),
                    style: TextStyle(
                      color: change.toDouble() < 0 ? Colors.red : Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    //percentage var
                    changePercentage.toDouble() < 0
                        ? changePercentage.toDouble().toStringAsFixed(2) + '%'
                        : '+' +
                            changePercentage.toDouble().toStringAsFixed(2) +
                            '%',
                    style: TextStyle(
                      color: changePercentage.toDouble() < 0
                          ? Colors.red
                          : Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
