/// payment_id : "3"
/// child_id : "8"
/// child_name : "mohammad Alassi"
/// payment_method : "VISA"
/// status : "1"
/// amount : "50"

class PaymentLogModel {
  PaymentLogModel({
    String? paymentId,
    String? childId,
    String? childName,
    String? paymentMethod,
    String? status,
    String? amount,
  }) {
    _paymentId = paymentId;
    _childId = childId;
    _childName = childName;
    _paymentMethod = paymentMethod;
    _status = status;
    _amount = amount;
  }

  PaymentLogModel.fromJson(dynamic json) {
    _paymentId = json['payment_id'];
    _childId = json['child_id'];
    _childName = json['child_name'];
    _paymentMethod = json['payment_method'];
    _status = json['status'];
    _amount = json['amount'];
  }

  String? _paymentId;
  String? _childId;
  String? _childName;
  String? _paymentMethod;
  String? _status;
  String? _amount;
  PaymentLogModel copyWith({
    String? paymentId,
    String? childId,
    String? childName,
    String? paymentMethod,
    String? status,
    String? amount,
  }) =>
      PaymentLogModel(
        paymentId: paymentId ?? _paymentId,
        childId: childId ?? _childId,
        childName: childName ?? _childName,
        paymentMethod: paymentMethod ?? _paymentMethod,
        status: status ?? _status,
        amount: amount ?? _amount,
      );
  String? get paymentId => _paymentId;

  String? get childId => _childId;

  String? get childName => _childName;

  String? get paymentMethod => _paymentMethod;

  String? get status => _status;

  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_id'] = _paymentId;
    map['child_id'] = _childId;
    map['child_name'] = _childName;
    map['payment_method'] = _paymentMethod;
    map['status'] = _status;
    map['amount'] = _amount;
    return map;
  }
}
