class CartSummary {
  final double subtotal;
  final double deliveryTotal;
  final double discountTotal;
  final double totalPrice;

  CartSummary({
    required this.subtotal,
    required this.deliveryTotal,
    required this.discountTotal,
    required this.totalPrice,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      deliveryTotal: (json['delivery_total'] as num?)?.toDouble() ?? 0.0,
      discountTotal: (json['discount_total'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['Total_price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}