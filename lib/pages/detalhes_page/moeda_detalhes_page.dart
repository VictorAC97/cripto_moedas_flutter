import 'package:cripto_moedas_flutter/model/Moeda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoedaDetalhesPage extends StatefulWidget {
  final Moeda moeda;
  const MoedaDetalhesPage({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MoedaDetalhesPage> createState() => _MoedaDetalhesPageState();
}

class _MoedaDetalhesPageState extends State<MoedaDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _controllerAmount = TextEditingController();
  double quantidade = 0;

  final dropValue = ValueNotifier('');
  final dropOptions = ['Audi', 'BMW', 'Ferrari', 'Lamborghini', 'Tesla'];

  comprar() {
    if (_form.currentState!.validate()) {
      //Salvar a compra
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compra realizada com sucesso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Hero(
                        tag: widget.moeda.icone,
                        child: Image.asset(widget.moeda.icone)),
                    height: 50,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    real.format(widget.moeda.preco),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            quantidade > 0
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Text(
                        '$quantidade ${widget.moeda.sigla}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.teal),
                      ),
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(color: Colors.teal.withOpacity(0.05)),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 24),
                  ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _controllerAmount,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    "reais",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra.';
                  } else if (double.parse(value) < 50) {
                    return "Compra mínima é 50 reais.";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade = value.isEmpty
                        ? 0
                        : double.parse(value) / widget.moeda.preco;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Comprar",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                onPressed: comprar,
              ),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            ValueListenableBuilder(
                valueListenable: dropValue,
                builder: (BuildContext context, String value, _) {
                  return SizedBox(
                    width: 280,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      icon: const Icon(Icons.drive_eta),
                      hint: const Text('Escolha a marca'),
                      decoration: InputDecoration(
                        label: const Text("Marca"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (escolha) =>
                          dropValue.value = escolha.toString(),
                      items: dropOptions
                          .map((op) => DropdownMenuItem(
                                child: Text(op),
                                value: op,
                              ))
                          .toList(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
