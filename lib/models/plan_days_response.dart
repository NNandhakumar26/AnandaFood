class PlanDaysResponse {
  String? id;
  List<String>? planDaysModel;
  String? message;
  int? status;
  bool? success;
  int? recordCount;

  PlanDaysResponse({
    this.id,
    this.planDaysModel,
    this.message,
    this.status,
    this.success,
    this.recordCount,
  });

  PlanDaysResponse.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    planDaysModel = json['data'].cast<String>();
    message = json['message'];
    status = json['status'];
    success = json['success'];
    recordCount = json['RecordCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['data'] = this.planDaysModel;
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    data['RecordCount'] = this.recordCount;
    return data;
  }
}
