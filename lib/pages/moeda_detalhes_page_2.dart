import 'package:cripto_moedas_flutter/model/Moeda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedaDetalhesPage2 extends StatefulWidget {
  Moeda moeda;
  MoedaDetalhesPage2({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MoedaDetalhesPage2> createState() => _MoedaDetalhesPage2State();
}

class _MoedaDetalhesPage2State extends State<MoedaDetalhesPage2> {
  NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(widget.moeda.nome),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  child: Hero(
                      tag: '${widget.moeda.icone}',
                      child: Image.asset(widget.moeda.icone)),
                  height: 200,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(72)),
                      Text(
                        widget.moeda.nome,
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.moeda.sigla,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        real.format(widget.moeda.preco),
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
