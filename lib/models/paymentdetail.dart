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

  PaymentDetail.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        sender = map['sender'],
        amount = map['amount'],
        currency = map['currency'],
        balance = map['balance'],
        reference = map['reference'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sender': sender,
      'amount': amount,
      'currency': currency,
      'balance': balance,
      'reference': reference,
    };
  }

  PaymentDetail copy({
    int? id,
    String? name,
    String? sender,
    String? amount,
    String? currency,
    String? balance,
    String? reference,
  }) {
    return PaymentDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      sender: sender ?? this.sender,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      reference: reference ?? this.reference,
    );
  }
}
