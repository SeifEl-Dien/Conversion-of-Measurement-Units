import 'package:flutter/material.dart';
import 'package:lab6/util.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Myapp()));
}

class Myapp extends StatefulWidget {
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  double _numberfrom = 0;
  String _startmeasure = 'meters';
  String _convertedmeasure = 'kilometers';
  String _resultmessage = '';
  double _result = 0;
  final List _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds',
    'ounces'
  ];

  final TextStyle inputstyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );

  final TextStyle labelstyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  @override
  void initState() {
    _numberfrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizex = MediaQuery.of(context).size.width;
    double sizey = MediaQuery.of(context).size.height;
    final spacer = Padding(padding: EdgeInsets.only(bottom: sizey / 30));

    return Scaffold(
      appBar: AppBar(
        title: Text('Measure Converter'),
        centerTitle: true,
      ),
      body: Container(
        width: sizex,
        padding: EdgeInsets.all(sizex / 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Value',
                style: labelstyle,
              ),
              spacer,
              TextField(
                keyboardType: TextInputType.number,
                style: inputstyle,
                decoration: InputDecoration(
                    hintText: 'Insert the measure to be converted'),
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberfrom = rv;
                    });
                  }
                },
              ),
              spacer,
              Text(
                'From',
                style: labelstyle,
              ),
              DropdownButton(
                isExpanded: true,
                style: inputstyle,
                items: _measures.map((nvalue) {
                  return DropdownMenuItem(
                    child: Text(nvalue),
                    value: nvalue,
                  );
                }).toList(),
                onChanged: (nvalue) {
                  onstartmeasurechanged(nvalue.toString());
                },
                value: _startmeasure,
              ),
              spacer,
              Text(
                'To',
                style: labelstyle,
              ),
              DropdownButton(
                isExpanded: true,
                style: inputstyle,
                items: _measures.map((uvalue) {
                  return DropdownMenuItem(
                    child: Text(uvalue),
                    value: uvalue,
                  );
                }).toList(),
                onChanged: (uvalue) {
                  onconvertedmeasurechanged(uvalue.toString());
                },
                value: _convertedmeasure,
              ),
              spacer,
              ElevatedButton(
                  child: Text(
                    'Convert',
                    style: inputstyle,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[400],
                  ),
                  onPressed: () {
                    convert();
                  }),
              spacer,
              Text(
                _resultmessage,
                style: labelstyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onstartmeasurechanged(String value) {
    setState(() {
      _startmeasure = value;
    });
  }

  void onconvertedmeasurechanged(String value) {
    setState(() {
      _convertedmeasure = value;
    });
  }

  void convert() {
    var c = Conversion();
    double result = c.convert(_numberfrom, _startmeasure, _convertedmeasure);
    setState(() {
      _result = result;
      if (result == 0) {
        _resultmessage = 'This conversion cant be done';
      } else {
        _resultmessage =
            '${_numberfrom.toString()} $_startmeasure are ${_result.toString()} $_convertedmeasure';
      }
    });
  }
}
