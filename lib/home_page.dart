import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model/financa.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //Lista de Objetos de Finança
  List<Financa> financasList = [
    Financa(mes: 'Janeiro', valor: 10000),
    Financa(mes: 'Fevereiro', valor: 20000),
    Financa(mes: 'Março', valor: 40000),
    Financa(mes: 'Abril', valor: 33000),
    Financa(mes: 'Maio', valor: 44000),
    Financa(mes: 'Junho', valor: 44000),
    Financa(mes: 'Julho', valor: 10000),
    Financa(mes: 'Agost', valor: 14000)
  ];

  //Retorna o maior e o menor valor da Lista de finanças
  List<double> returnValoresEixoY(List<Financa> financas) {
    double menorValor = financas
        .map((financa) => financa.valor)
        .reduce((curr, next) => curr < next ? curr : next);
    double maiorValor = financas
        .map((financa) => financa.valor)
        .reduce((curr, next) => curr > next ? curr : next);

    return [menorValor - (menorValor * .2), maiorValor + (maiorValor * .2)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () {},
            label: const Icon(Icons.plus_one)),
        body: Container(
          color: Colors.green[900],
          child: Column(
            children: [
              const Text(
                'R\$ 900,00',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Gasto Total do mês',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightGreenAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.blueGrey],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(color: Colors.white)),
                      primaryYAxis: NumericAxis(
                        minimum: returnValoresEixoY(financasList)[0],
                        maximum: returnValoresEixoY(financasList)[1],
                        interval: (returnValoresEixoY(financasList)[1] ~/ 5)
                            .toDouble(),
                        labelPosition: ChartDataLabelPosition.outside,
                        labelAlignment: LabelAlignment.end,
                        rangePadding: ChartRangePadding.additional,
                        labelStyle:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      series: <ChartSeries>[
                        ColumnSeries<Financa, String>(
                            dataSource: financasList,
                            xValueMapper: (Financa financa, _) => financa.mes,
                            yValueMapper: (Financa financa, _) => financa.valor,
                            color: Colors.white)
                      ],
                      // Configurando a propriedade tooltipBehavior
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        header: '',
                        canShowMarker: false,
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 3)
                              ],
                            ),
                            child: Text('R\$${point.y}'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: financasList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {},
                              leading: const Icon(Icons.attach_money_rounded),
                              title: Text(
                                  'Gastos Totais do Mês de ${financasList[index].mes}'),
                              subtitle:
                                  Text('R\$ ${financasList[index].valor}'),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
