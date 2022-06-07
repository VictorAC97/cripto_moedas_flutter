import 'package:cripto_moedas_flutter/pages/favoritas_page/widgets/moeda_card_widget.dart';
import 'package:cripto_moedas_flutter/pages/todas_page/moedas_page.dart';
import 'package:cripto_moedas_flutter/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  FavoritasPage({Key? key}) : super(key: key);

  late FavoritasRepository favoritas;

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moedas Favoritas'),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.indigo.withOpacity(0.05),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(12),
          child: Consumer<FavoritasRepository>(
            builder: ((context, favoritas, child) {
              return favoritas.lista.isEmpty
                  ? const ListTile(
                      leading: Icon(Icons.star),
                      title: Text('Ainda não há moedas favoritas'),
                    )
                  : ListView.builder(
                      itemCount: favoritas.lista.length,
                      itemBuilder: ((context, index) {
                        return MoedaCard(moeda: favoritas.lista[index]);
                      }));
            }),
          )),
    );
  }
}
