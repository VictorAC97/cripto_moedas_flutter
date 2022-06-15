import 'package:cripto_moedas_flutter/config/app_settings.dart';
import 'package:cripto_moedas_flutter/model/Moeda.dart';
import 'package:cripto_moedas_flutter/pages/detalhes_page/moeda_detalhes_page.dart';
import 'package:cripto_moedas_flutter/repositories/favoritas_repository.dart';
import 'package:cripto_moedas_flutter/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

List<Moeda> selecionadas = [];
final tabela = MoedaRepository.listaMoedas;
late NumberFormat real;
late Map<String, String> loc;
late FavoritasRepository favoritas;

class _MoedasPageState extends State<MoedasPage> {
  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
        icon: const Icon(Icons.language),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.swap_vert),
                  title: Text('Usar $locale'),
                  onTap: () {
                    context.read<AppSettings>().setLocale(locale, name);
                    Navigator.pop(context);
                  },
                ),
              ),
            ]);
  }

  appBarDinamica() {
    return selecionadas.isEmpty
        ? AppBar(
            title: const Text("Cripto Moedas"),
            centerTitle: true,
            actions: [
              changeLanguageButton(),
            ],
          )
        : AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  selecionadas = [];
                });
              },
            ),
            backgroundColor: Colors.blueGrey[50],
            elevation: 1,
            title: Text("${selecionadas.length.toString()} selecionadas"),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black87),
            titleTextStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          );
  }

  @override
  Widget build(BuildContext context) {
    //instanciando a lista de favoritas com o provider
    //favoritas = Provider.of<FavoritasRepository>(context);  //forma 1
    favoritas = context.watch<FavoritasRepository>(); //forma 2
    readNumberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemCount: tabela.length,
        separatorBuilder: (__, _) => const Divider(),
        padding: const EdgeInsets.all(16),
        itemBuilder: ((context, index) {
          return ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              selected: selecionadas.contains(tabela[index]),
              selectedTileColor: Colors.indigo[50],
              title: Row(
                children: [
                  Text(
                    tabela[index].nome,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  if (favoritas.lista.contains(tabela[index]))
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                ],
              ),
              leading: selecionadas.contains(tabela[index])
                  ? const CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      width: 40,
                      child: Hero(
                          tag: tabela[index].icone,
                          child: Image.asset(tabela[index].icone))),
              trailing: Text(real.format(tabela[index].preco),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
              onLongPress: () {
                setState(() {
                  selecionadas.contains(tabela[index])
                      ? selecionadas.remove(tabela[index])
                      : selecionadas.add(tabela[index]);
                });
              },
              onTap: () => mostrarDetalhes(tabela[index]));
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              label: const Text("FAVORITAR"),
              icon: const Icon(Icons.favorite),
            )
          : null,
    );
  }

  //funcoes

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoedaDetalhesPage(moeda: moeda),
      ),
    );
  }
}
