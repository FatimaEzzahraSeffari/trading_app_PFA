import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trading/widgets/CustomAppBar.dart';
import '../constants.dart';
import '../services/TradingServices.dart';
import '../utils.dart';
import 'ChartPage.dart';

class TablePage extends StatefulWidget {
  final int volume;
  final int isAbove10;
  final double priceRangeMin;
  final double priceRangeMax;
  final int marketCap;
  const TablePage(
      {Key? key,
      required this.volume,
      required this.isAbove10,
      required this.priceRangeMin,
      required this.priceRangeMax,
      required this.marketCap})
      : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<dynamic> _data = [];
  bool _isLoading = true;
  bool ascending = true;

  @override
  void initState() {
    super.initState();
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    Timer(const Duration(seconds: 12), () {
      if (_data.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        // Show error message or take any other appropriate action
      }
    });

    final List<dynamic> filteredData = await TradingService.fetchData(
        widget.volume,
        widget.isAbove10,
        widget.priceRangeMin,
        widget.priceRangeMax,
        widget.marketCap);
    setState(() {
      _isLoading = false;
      _data = filteredData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat('#,###.##');
    final percentFormatter = NumberFormat('##.##%');
    return Scaffold(
      appBar: CustomAppBar(title: 'Stock Scanner',),
      body: Container(
        color: darkTheme.primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: _isLoading
            ? Center(
                child: Container(width: 150,height: 150,child: Image.asset('assets/square-loading.gif')))
            : _data.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Image.asset('assets/no_data.gif'),
                      const SizedBox(height: 40),
                      Text('There is no Data to show',
                        style: GoogleFonts.lato(
                          color: Color(0xFF7B8D93),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Try Again',
                        style: GoogleFonts.lato(
                          color: Color(0xFF7B8D93),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ))
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      border: const TableBorder(
                        horizontalInside:
                            BorderSide(color: Color(0xFF7B8D93), width: 0.5),
                      ),
                      columnSpacing: 2.0,
                      showCheckboxColumn: false,
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => const Color(0xFF7B8D93)),
                      columns: [
                        DataColumn(
                          label: Text('Symbol',style: GoogleFonts.poppins( fontSize: 12, )),
                          onSort: (columnIndex, _) {
                            setState(() {
                              ascending = !ascending;
                              _data.sort((a, b) => compareString(
                                  ascending, a['Code'], b['Code']));
                            });
                          },
                        ),
                        DataColumn(
                          label: Text('Price',
                              style: GoogleFonts.poppins( fontSize: 12,)),
                          onSort: (columnIndex, _) {
                            setState(() {
                              ascending = !ascending;
                              _data.sort((a, b) => compareString(
                                  ascending, a['Close'], b['Close']));
                            });
                          },
                        ),
                        DataColumn(
                          label: Text('Volume',style: GoogleFonts.poppins(fontSize: 12,)),
                          onSort: (columnIndex, _) {
                            setState(() {
                              ascending = !ascending;
                              _data.sort((a, b) => compareInt(
                                  ascending,
                                  int.parse(a['Volume']),
                                  int.parse(b['Volume'])));
                            });
                          },
                        ),
                        DataColumn(
                          label: Text('Market Cap',style: GoogleFonts.poppins(fontSize: 11,)),
                          onSort: (columnIndex, _) {
                            setState(() {
                              ascending = !ascending;
                              _data.sort((a, b) => compareInt(
                                  ascending,
                                  int.parse(a['MarketCapitalization']),
                                  int.parse(b['MarketCapitalization'])));
                            });
                          },
                        ),
                        DataColumn(
                          label: Text('%Change', style: GoogleFonts.poppins(fontSize: 11,)),
                          onSort: (columnIndex, _) {
                            setState(() {
                              ascending = !ascending;
                              _data.sort((a, b) => compareString(
                                  ascending,
                                  (double.parse(a['percent_change']) / 100)
                                      .toString(),
                                  (double.parse(b['percent_change']) / 100)
                                      .toString()));
                            });
                          },
                        ),
                      ],
                      rows: _data
                          .map((item) => DataRow(
                                  selected: false,
                                  onSelectChanged: (selected) {
                                    if (selected == true) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChartPage(code: item['Code'],
                                                  )));
                                    }
                                  },
                                  cells: [
                                    DataCell(
                                      Text(item['Code'],style: const TextStyle(color: Color(0xFF7B8D93),)),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2, right: 4),
                                        child: Text(
                                            numberFormatter.format(
                                                double.parse(item['Close'])),
                                            style: const TextStyle(
                                                color: Color(0xFF7B8D93))),
                                      ),
                                    ),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 100),
                                        child: Text(
                                          numberFormatter.format(
                                              double.parse(item['Volume'])),
                                          style: const TextStyle(
                                              color: Color(0xFF7B8D93)),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                            maxWidth: 107, minWidth: 90),
                                        child: Text(
                                          numberFormatter.format(double.parse(
                                              item['MarketCapitalization']
                                                  .replaceAll(',', ''))),
                                          style: const TextStyle(
                                              color: Color(0xFF7B8D93)),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                          percentFormatter.format(double.parse(
                                                  item['percent_change']) /
                                              100),
                                          style: const TextStyle(
                                            color: Color(0xFF7B8D93),
                                          )),
                                    ),
                                  ]))
                          .toList(),
                    ),
                  ),
      ),
    );
  }
}
