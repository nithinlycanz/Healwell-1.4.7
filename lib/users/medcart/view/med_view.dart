import 'package:healwell/general/consts/consts.dart';
import 'package:flutter/material.dart';

class MedCartView extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedCartView> {
  int _doloCount = 0;
  int _citrizineCount = 0;
  int _paracetamolCount = 0;
  int _doloPrize = 0;
  int _citrizinePrize = 0;
  int _paracetamolPrize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Medication List'),
        ),
        body: ListView(
          children: <Widget>[
            _buildMedication(
                'Dolo-650 mg',
                _doloPrize,
                4.4,
                _doloCount,
                _incrementDolo,
                _decrementDolo,
                _incrementDoloPrize,
                _decrementDoloPrize),
            _buildMedication(
                'Citrizine',
                _citrizinePrize,
                3.6,
                _citrizineCount,
                _incrementCitrizine,
                _decrementCitrizine,
                _incrementCitrizinePrize,
                _decrementCitrizinePrize),
            _buildMedication(
                'Paracetamol 500 mg',
                _paracetamolPrize,
                4.1,
                _paracetamolCount,
                _incrementParacetamol,
                _decrementParacetamol,
                _incrementParacetamolPrize,
                _decrementParacetamolPrize),
          ],
        ));
  }

  Widget _buildMedication(
      String name,
      int price,
      double rating,
      int count,
      Function increment,
      Function decrement,
      Function incrementPrize,
      Function decrementPrize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\$' + '$price USD'),
              Text('Rating: $rating'),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    increment();
                    incrementPrize();
                  }),
              Text('$count'),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    decrement();
                    decrementPrize();
                  }),
            ],
          ),
        ],
      ),
    );
  }

  void _incrementDolo() {
    setState(() {
      _doloCount++;
    });
  }

  void _incrementCitrizine() {
    setState(() {
      _citrizineCount++;
    });
  }

  void _incrementParacetamol() {
    setState(() {
      _paracetamolCount++;
    });
  }

  void _decrementDolo() {
    setState(() {
      if (_doloCount > 0) {
        _doloCount--;
      }
    });
  }

  void _decrementCitrizine() {
    setState(() {
      if (_citrizineCount > 0) {
        _citrizineCount--;
      }
    });
  }

  void _decrementParacetamol() {
    setState(() {
      if (_paracetamolCount > 0) {
        _paracetamolCount--;
      }
    });
  }

  void _incrementDoloPrize() {
    setState(() {
      _doloPrize += 10;
    });
  }

  void _incrementCitrizinePrize() {
    setState(() {
      _citrizinePrize += 20;
    });
  }

  void _incrementParacetamolPrize() {
    setState(() {
      _paracetamolPrize += 15;
    });
  }

  void _decrementDoloPrize() {
    setState(() {
      if (_doloPrize > 0) {
        _doloPrize = _doloPrize - 10;
      }
    });
  }

  void _decrementCitrizinePrize() {
    setState(() {
      if (_citrizinePrize > 0) {
        _citrizinePrize = _citrizinePrize - 20;
      }
    });
  }

  void _decrementParacetamolPrize() {
    setState(() {
      if (_paracetamolPrize > 0) {
        _paracetamolPrize = _paracetamolPrize - 15;
      }
    });
  }
}
