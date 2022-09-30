import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_jti/database/db_helper.dart';
import 'package:lsp_jti/model/cash_flow.dart';

class PemasukanPage extends StatefulWidget {
  const PemasukanPage({super.key});

  @override
  State<PemasukanPage> createState() => _PemasukanPageState();
}

class _PemasukanPageState extends State<PemasukanPage> {
  DbHelper db = DbHelper();

  late TextEditingController tgl = TextEditingController();
  late TextEditingController pemasukan = TextEditingController();
  late TextEditingController keterangan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> upsertCashFlow() async {
      print("${tgl.text} | ${int.parse(pemasukan.text)} | ${keterangan.text}");

      await db.saveCashFlow(CashFlow(
        tgl: tgl.text,
        cash: int.parse(pemasukan.text),
        jenis: 'pemasukan',
        keterangan: keterangan.text,
      ));
      Navigator.pop(context, 'save');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pemasukan'),
        backgroundColor: const Color(0xFF7BBA4A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              readOnly: true,
              controller: tgl,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.calendar_month),
                labelText: 'Tanggal',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  print("formattedDate : $formattedDate");
                  setState(() {
                    tgl.text = formattedDate;
                    print("tgl.text : ${tgl.text}");
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              controller: pemasukan,
              decoration: InputDecoration(
                  labelText: 'Nominal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: keterangan,
              decoration: InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: const Color(0xFF7BBA4A),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              child: const Text(
                'Simpan',
              ),
              onPressed: () {
                upsertCashFlow();
              },
            ),
          )
        ],
      ),
    );
  }
}
