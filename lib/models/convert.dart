class Convert {
  String amount;
  String result;
  Convert({required this.amount, required this.result});

  factory Convert.fromJson(Map<String, dynamic> json) => Convert(
        amount: json["amount"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "result": result,
      };
}
