import 'package:cripto_moedas_flutter/pages/favoritas_page/favoritas_page.dart';
import 'package:cripto_moedas_flutter/pages/todas_page/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _controller;
  int paginaAtual = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: paginaAtual);
    super.initState();
  }

  setPaginaAtual(int index) {
    setState(() {
      paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          const MoedasPage(),
          FavoritasPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          selectedIndex: paginaAtual,
          onDestinationSelected: (index) {
            _controller.animateToPage(index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.list_outlined,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: "Todas"),
            NavigationDestination(
                icon: Icon(
                  Icons.favorite_outline,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Icons.favorite,
                  size: 30,
                ),
                label: "Favoritas"),
          ],
        ),
      ),
    );
  }
}
