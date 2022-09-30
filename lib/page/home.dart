import 'package:flutter/material.dart';
import 'package:lsp_jti/database/db_helper.dart';
import 'package:lsp_jti/model/cash_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper db = DbHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<int> _getTotalPemasukan() async {
      var list = await db.getTotalPemasukan();
      var totalPemasukan =
          (await db.getTotalPemasukan())![0]['total_pemasukan'];
      totalPemasukan = (totalPemasukan == null) ? 0 : totalPemasukan;
      return totalPemasukan;
    }

    Future<int> _getTotalPengeluaran() async {
      var list = await db.getTotalPengeluaran();
      var totalPengeluaran =
          (await db.getTotalPengeluaran())![0]['total_pengeluaran'];
      totalPengeluaran = (totalPengeluaran == null) ? 0 : totalPengeluaran;
      return totalPengeluaran;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome, user'),
        backgroundColor: const Color(0xFF7BBA4A),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF7BBA4A),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 10.0, top: 20.0),
                            child: FutureBuilder<dynamic>(
                                future: _getTotalPengeluaran(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);
                                  return snapshot.hasData
                                      ? Text(
                                          snapshot.data.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.0,
                                          ),
                                        );
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: const Text(
                              "Pengeluaran",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 10.0, top: 20.0),
                            child: FutureBuilder<dynamic>(
                                future: _getTotalPemasukan(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);
                                  return snapshot.hasData
                                      ? Text(
                                          snapshot.data.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.0,
                                          ),
                                        );
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: const Text(
                              "Pemasukan",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 10.0, bottom: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(1.0),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(20),
                                      child: const FittedBox(
                                        child: Icon(Icons.arrow_circle_up,
                                            color: Color(0xFF7BBA4A)),
                                      ),
                                    ),
                                  ),
                                  const Text("Tambah Pemasukan"),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed('/pemasukan');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(1.0),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(20),
                                      child: const FittedBox(
                                        child: Icon(Icons.arrow_circle_down,
                                            color: Color(0xFF7BBA4A)),
                                      ),
                                    ),
                                  ),
                                  const Text("Tambah Pengeluaran"),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed('/pengeluaran');
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 10.0, bottom: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(1.0),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(20),
                                      child: const FittedBox(
                                        child: Icon(Icons.list_alt_outlined,
                                            color: Color(0xFF7BBA4A)),
                                      ),
                                    ),
                                  ),
                                  const Text("Detail Cash Flow"),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed('/detail');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(1.0),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(20),
                                      child: const FittedBox(
                                        child: Icon(Icons.settings,
                                            color: Color(0xFF7BBA4A)),
                                      ),
                                    ),
                                  ),
                                  const Text("Pengaturan"),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed('/pengaturan');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
