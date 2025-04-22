class PaymentMethod {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;

  PaymentMethod({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
  });
}
