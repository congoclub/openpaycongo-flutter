class PaymentDetail {
  final int? id;
  final String name;
  final String sender;
  final String amount;
  final String currency;
  final String balance;
  final String reference;

  PaymentDetail({
    this.id,
    required this.name,
    required this.sender,
    required this.amount,
    required this.currency,
    required this.balance,
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'sender': sender,
        'amount': amount,
        'currency': currency,
        'balance': balance,
        'reference': reference,
      };

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sender': sender,
      'amount': amount,
      'currency': currency,
      'balance': balance,
      'reference': reference,
    };
  }
}
