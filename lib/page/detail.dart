import 'package:flutter/material.dart';
import 'package:lsp_jti/database/db_helper.dart';
import 'package:lsp_jti/model/cash_flow.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<CashFlow> listCashFlow = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllCashFlow();
    super.initState();
  }

  Future<void> _getAllCashFlow() async {
    var list = await db.getAllCashFlow();
    setState(() {
      listCashFlow.clear();
      list!.forEach((cashFlow) {
        listCashFlow.add(CashFlow.fromMap(cashFlow));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cash Flow'),
        backgroundColor: const Color(0xFF7BBA4A),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listCashFlow.length,
            itemBuilder: (context, index) {
              CashFlow cashFlow = listCashFlow[index];
              return Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text((cashFlow.jenis == 'pengeluaran')
                      ? '[-] ' ' ${cashFlow.cash}'
                      : '[+] ' ' ${cashFlow.cash}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text('${cashFlow.keterangan}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("${cashFlow.tgl}"),
                      ),
                    ],
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: IconButton(
                      onPressed: () {},
                      icon: (cashFlow.jenis == 'pengeluaran')
                          ? const Icon(
                              Icons.arrow_forward,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.arrow_back,
                              color: Colors.green,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
