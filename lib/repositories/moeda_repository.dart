import '../model/Moeda.dart';

class MoedaRepository {
  static List<Moeda> listaMoedas = [
    Moeda(
      nome: "Avalanche",
      sigla: "AVAX",
      icone: "images/avalanche.png",
      preco: 147.00,
    ),
    Moeda(
      nome: "Bitcoin",
      sigla: "BTC",
      icone: "images/bitcoin.png",
      preco: 149270.00,
    ),
    Moeda(
      nome: "Cardano",
      sigla: "ADA",
      icone: "images/cardano.png",
      preco: 2.60,
    ),
    Moeda(
      nome: "Dogecoin",
      sigla: "DOGE",
      icone: "images/dogecoin.png",
      preco: 0.4251,
    ),
    Moeda(
      nome: "Ethereum",
      sigla: "ETH",
      icone: "images/ethereum.png",
      preco: 9913.31,
    ),
    Moeda(
      nome: "Litecoin",
      sigla: "LTC",
      icone: "images/litecoin.png",
      preco: 351.58,
    ),
    Moeda(
      nome: "Polkadot",
      sigla: "DOT",
      icone: "images/polkadot.png",
      preco: 49.37,
    ),
    Moeda(
      nome: "Shiba Inu",
      sigla: "SHIB",
      icone: "images/shib.png",
      preco: 0.00005797,
    ),
    Moeda(
      nome: "Terra",
      sigla: "LUNA",
      icone: "images/terraluna.png",
      preco: 0.0007,
    ),
    Moeda(
      nome: "USD Coin",
      sigla: "USDC",
      icone: "images/usdcoin.png",
      preco: 4.93,
    ),
    Moeda(
      nome: "XRP",
      sigla: "XRP",
      icone: "images/xrp.png",
      preco: 2.06,
    ),
  ];
}
