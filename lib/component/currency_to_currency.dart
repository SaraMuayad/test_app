import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/Utils/colors.dart';
import 'package:test_app/Utils/operator.dart';
import 'package:test_app/history_screen/history.dart';
import 'package:test_app/models/convert.dart';

class CurrencyToCurrency extends StatefulWidget {
  final rates;
  final Map currencies;
  const CurrencyToCurrency(
      {Key? key, required this.rates, required this.currencies})
      : super(key: key);

  @override
  _CurrencyToCurrencyState createState() => _CurrencyToCurrencyState();
}

class _CurrencyToCurrencyState extends State<CurrencyToCurrency> {
  ConvertCurr convertCurr = ConvertCurr();
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';
  String answer = 'Amount Converted';

  List<Convert> convert = List.empty(growable: true);
  int selectedIndex = -1;

  late SharedPreferences sharedPreferences;

  getSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {
    //
    List<String> convertListString =
        convert.map((convert) => jsonEncode(convert.toJson())).toList();
    sharedPreferences.setStringList('myData', convertListString);
    //
  }

  readFromSp() {
    //
    List<String>? convertListString = sharedPreferences.getStringList('myData');
    if (convertListString != null) {
      convert = convertListString
          .map((convert) => Convert.fromJson(json.decode(convert)))
          .toList();
    }
    setState(() {});
    //
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefrences();
    // getValues();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 40),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Icon(Icons.bubble_chart),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10),
              child: Icon(Icons.bubble_chart),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Container(
          // width: w / 3,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Convert Currency',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
                ),
              ),
              const SizedBox(height: 30),

              //TextFields for Entering USD

              Center(
                child: Container(
                  width: 300,
                  height: 50,
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    key: const ValueKey('amount'),
                    cursorColor: Colors.black,
                    // keyboardType: TextInputType.,
                    decoration: const InputDecoration(
                      hintText: 'Enter Amount',
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border

                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(12),
                          right: Radius.circular(12),
                        ),
                        borderSide: BorderSide(color: Colors.black, width: 0.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(12),
                          right: Radius.circular(12),
                        ),
                      ),
                      hintStyle: TextStyle(fontSize: 15),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: DropdownButton<String>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(value),
                            ));
                      }).toList(),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                ColorResources.purple4D5,
                                ColorResources.redD90
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            )),
                        child: const Center(
                          child: Icon(Icons.currency_exchange,
                              color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          answer =
                              '${amountController.text} $dropdownValue1 = ${convertCurr.convert(widget.rates, amountController.text, dropdownValue1, dropdownValue2)} $dropdownValue2';
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue2 = newValue!;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Center(
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          ColorResources.purple4D5,
                          ColorResources.redD90
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(answer,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  icon: const Icon(Icons.safety_check),
                  onPressed: () async {
                    setState(() {
                      convert.add(Convert(
                          amount: amountController.text, result: answer));
                      saveIntoSp();
                    });
                  },
                ),
              ),
              // const SizedBox(height: 10),
              // Text(newValue),

              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: convert.isEmpty
                    ? const Center(
                        child: Text(
                          'No Contact yet..',
                          style: TextStyle(fontSize: 22),
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: convert.length,
                          itemBuilder: (context, index) => getRow(index),
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            convert[index].amount,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              convert[index].amount,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(convert[index].result),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      convert.removeAt(index);
                    });
                    // Saving contacts list into Shared Prefrences
                    saveIntoSp();
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
