class PixModel{
  final String order_id;
  final String title;
  final String total_order;
  final String payment_date;
  final String status;

  PixModel({required this.order_id,
    required this.title,
    required this.total_order,
    required this.payment_date,
    required this.status,
  });

  factory PixModel.fromMap(Map<String, dynamic> map) {
    return PixModel(
        order_id: map["order_id"] ?? "",
        title: map["title"]?? "",
        total_order: map["total_order"]?? "",
        payment_date: map["payment_date"]?? "",
        status: map["status"]?? "");
  }

}