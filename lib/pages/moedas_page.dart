import 'package:cripto_moedas_flutter/model/Moeda.dart';
import 'package:cripto_moedas_flutter/pages/moeda_detalhes_page.dart';
import 'package:cripto_moedas_flutter/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

List<Moeda> selecionadas = [];
final tabela = MoedaRepository.listaMoedas;
NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');

class _MoedasPageState extends State<MoedasPage> {
  @override
  Widget build(BuildContext context) {
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
              title: Text(
                tabela[index].nome,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              leading: selecionadas.contains(tabela[index])
                  ? const CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      width: 40,
                      child: Hero(
                          tag: '${tabela[index].icone}',
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
              onPressed: () {},
              label: const Text("FAVORITAR"),
              icon: const Icon(Icons.favorite),
            )
          : null,
    );
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoedaDetalhesPage(moeda: moeda),
      ),
    );
  }

  appBarDinamica() {
    return selecionadas.isEmpty
        ? AppBar(
            title: const Text("Cripto Moedas"),
            centerTitle: true,
          )
        : AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
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
}
