import 'package:cripto_moedas_flutter/config/app_settings.dart';
import 'package:cripto_moedas_flutter/config/hive_config.dart';
import 'package:cripto_moedas_flutter/pages/home/home_page.dart';
import 'package:cripto_moedas_flutter/repositories/conta_repository.dart';
import 'package:cripto_moedas_flutter/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //garante a inicializacao das widgets antes do runApp p n dar erro
  await HiveConfig.start();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: const MeuAplicativo(),
    ),

    //const MeuAplicativo(),
  );
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
