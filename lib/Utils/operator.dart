class ConvertCurr {
  String convert(
    Map exchangeRates,
    String amount,
    String currencyBase,
    String currencyFinal,
  ) {
    // double usdAmount = double.parse(amount) / exchangeRates[currencyBase];
    // print(usdAmount);
    // String output = (usdAmount * exchangeRates[currencyFinal])
    //     .toStringAsFixed(4)
    //     .toString();

    String output = (double.parse(amount) /
            exchangeRates[currencyBase] *
            exchangeRates[currencyFinal])
        .toStringAsFixed(2)
        .toString();

    print(output);
    return output;
  }
}
