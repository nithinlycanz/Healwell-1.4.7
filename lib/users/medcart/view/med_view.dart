import 'package:flutter/material.dart';

class MedCartView extends StatefulWidget {
  @override
  _MedCartViewState createState() => _MedCartViewState();
}

class _MedCartViewState extends State<MedCartView> {
  int _doloCount = 0;
  int _citrizineCount = 0;
  int _paracetamolCount = 0;
  int _doloPrize = 50; // Initialized with the correct value
  int _citrizinePrize = 40; // Initialized with the correct value
  int _paracetamolPrize = 30; // Initialized with the correct value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine cart'),
        backgroundColor: Color(0xFFD05508),
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
            _decrementDoloPrize,
          ),
          _buildMedication(
            'Citrizine',
            _citrizinePrize,
            3.6,
            _citrizineCount,
            _incrementCitrizine,
            _decrementCitrizine,
            _incrementCitrizinePrize,
            _decrementCitrizinePrize,
          ),
          _buildMedication(
            'Paracetamol 500 mg',
            _paracetamolPrize,
            4.1,
            _paracetamolCount,
            _incrementParacetamol,
            _decrementParacetamol,
            _incrementParacetamolPrize,
            _decrementParacetamolPrize,
          ),
          ElevatedButton(
            onPressed: _buyMedicines,
            child: Text('Buy Medicines'),
          ),
        ],
      ),
    );
  }

  Widget _buildMedication(
    String name,
    int price,
    double rating,
    int count,
    Function increment,
    Function decrement,
    Function incrementPrize,
    Function decrementPrize,
  ) {
    return Container(
      color: Color.fromARGB(255, 192, 219, 172),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('\₹' + '$price RUP'),
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
                },
              ),
              Text('$count'),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  decrement();
                  decrementPrize();
                },
              ),
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
        _doloPrize -= 10;
      }
    });
  }

  void _decrementCitrizinePrize() {
    setState(() {
      if (_citrizinePrize > 0) {
        _citrizinePrize -= 20;
      }
    });
  }

  void _decrementParacetamolPrize() {
    setState(() {
      if (_paracetamolPrize > 0) {
        _paracetamolPrize -= 15;
      }
    });
  }

  void _buyMedicines() {
    if (_doloCount > 0 || _citrizineCount > 0 || _paracetamolCount > 0) {
      // Calculate total price
      int totalPrice = (_doloCount * _doloPrize) +
          (_citrizineCount * _citrizinePrize) +
          (_paracetamolCount * _paracetamolPrize);

      // Display the QR code in a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Purchase'),
            content: Column(
              children: [
                Text('Total Price: \₹${totalPrice.toString()} RUP'),
                SizedBox(height: 20), // Add some space between the text and the image
                Image.asset('assets/qr_code.png'), // Load the QR code from assets
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Here you can implement your logic to process the purchase.
                  Navigator.of(context).pop();
                  // Clear counts after successful purchase
                  setState(() {
                    _doloCount = 0;
                    _citrizineCount = 0;
                    _paracetamolCount = 0;
                  });
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      // Show error message if no medicine is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select at least one medicine to purchase.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
