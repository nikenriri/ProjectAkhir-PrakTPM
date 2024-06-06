import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  String? valueschoose;
  String? valueschoose1;

  @override
  Widget build(BuildContext context) {
    final _amount = TextEditingController();
    final _tot = TextEditingController();
    double cal;
    double result;

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              TextField(
                controller: _amount,
                decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle:
                    const TextStyle(fontSize: 15, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 15),
              DropdownButton<String>(
                  value: this.valueschoose,
                  items: <String>['CNY', 'SAR', 'USD'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => this.valueschoose = value)),
              const SizedBox(height: 15),
              DropdownButton<String>(
                value: this.valueschoose1,
                items: <String>['IDR'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => this.valueschoose1 = value),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _tot,
                decoration: InputDecoration(
                    labelText: "Total",
                    labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                  onTap: () {
                    if (valueschoose == "CNY" && valueschoose1 == "IDR") {
                      cal = int.parse(_amount.text) * 2256.34;
                      result = cal;
                      _tot.text = result.toString();
                    } else if (valueschoose == "SAR" &&
                        valueschoose1 == "IDR") {
                      cal = int.parse(_amount.text) * 4278.44;
                      result = cal;
                      _tot.text = result.toString();
                    } else if (valueschoose == "USD" &&
                        valueschoose1 == "IDR") {
                      cal = int.parse(_amount.text) * 16045.00;
                      result = cal;
                      _tot.text = result.toString();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Convert",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
