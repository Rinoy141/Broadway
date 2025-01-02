class PortionOption {
  final String name;
  final double price;

  PortionOption({
    required this.name,
    required this.price,
  });

  factory PortionOption.fromJson(String name, double price) {
    return PortionOption(
      name: name,
      price: price,
    );
  }
}