class GenerateContractResponse {
  String? id;
  GenerateContractModel? generateContractModel;
  String? message;
  int? status;
  bool? success;
  int? recordCount;

  GenerateContractResponse(
      {this.id,
      this.generateContractModel,
      this.message,
      this.status,
      this.success,
      this.recordCount});

  GenerateContractResponse.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    generateContractModel = json['data'] != null
        ? new GenerateContractModel.fromJson(json['data'])
        : null;
    message = json['message'];
    status = json['status'];
    success = json['success'];
    recordCount = json['RecordCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    if (this.generateContractModel != null) {
      data['data'] = this.generateContractModel!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    data['RecordCount'] = this.recordCount;
    return data;
  }
}

class GenerateContractModel {
  String? id;
  int? tenetId;
  int? planId;
  int? customerId;
  int? defaultDayB4PlanStart;
  String? weekHoliday;
  String? weekofDay;
  int? mealRepeatInYear;
  int? totalSubDays;
  String? weekStartWithDay;
  int? enterDay;
  int? totalWeek;
  int? daysTotal;
  int? deliveryTime;
  String? startDate;
  String? endDate;
  double? planPrice;
  PlanmealinvoiceHD? planmealinvoiceHD;

  GenerateContractModel(
      {this.id,
      this.tenetId,
      this.planId,
      this.customerId,
      this.defaultDayB4PlanStart,
      this.weekHoliday,
      this.weekofDay,
      this.mealRepeatInYear,
      this.totalSubDays,
      this.weekStartWithDay,
      this.enterDay,
      this.totalWeek,
      this.daysTotal,
      this.deliveryTime,
      this.startDate,
      this.endDate,
      this.planPrice,
      this.planmealinvoiceHD});

  GenerateContractModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    tenetId = json['TenetId'];
    planId = json['PlanId'];
    customerId = json['CustomerId'];
    defaultDayB4PlanStart = json['DefaultDayB4PlanStart'];
    weekHoliday = json['Week_Holiday'];
    weekofDay = json['WeekofDay'];
    mealRepeatInYear = json['MealRepeatInYear'];
    totalSubDays = json['TotalSubDays'];
    weekStartWithDay = json['Week_Start_With_Day'];
    enterDay = json['EnterDay'];
    totalWeek = json['TotalWeek'];
    daysTotal = json['DaysTotal'];
    deliveryTime = json['DeliveryTime'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    planPrice = json['PlanPrice'];
    planmealinvoiceHD = json['planmealinvoiceHD'] != null
        ? new PlanmealinvoiceHD.fromJson(json['planmealinvoiceHD'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['TenetId'] = this.tenetId;
    data['PlanId'] = this.planId;
    data['CustomerId'] = this.customerId;
    data['DefaultDayB4PlanStart'] = this.defaultDayB4PlanStart;
    data['Week_Holiday'] = this.weekHoliday;
    data['WeekofDay'] = this.weekofDay;
    data['MealRepeatInYear'] = this.mealRepeatInYear;
    data['TotalSubDays'] = this.totalSubDays;
    data['Week_Start_With_Day'] = this.weekStartWithDay;
    data['EnterDay'] = this.enterDay;
    data['TotalWeek'] = this.totalWeek;
    data['DaysTotal'] = this.daysTotal;
    data['DeliveryTime'] = this.deliveryTime;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['PlanPrice'] = this.planPrice;
    if (this.planmealinvoiceHD != null) {
      data['planmealinvoiceHD'] = this.planmealinvoiceHD!.toJson();
    }
    return data;
  }
}

class PlanmealinvoiceHD {
  String? id;
  int? tenentID;
  int? mYTRANSID;
  int? lOCATIONID;
  int? customerID;
  int? planid;
  int? dayNumber;
  int? transID;
  String? contractID;
  int? defaultDriverID;
  String? contractDate;
  String? weekofDay;
  String? startDate;
  String? endDate;
  int? totalAmount;
  int? paidAmount;
  int? allowWeekend;
  int? totalSubDays;
  int? deliveredDays;
  String? nExtDeliveryDate;
  int? nExtDeliveryNum;
  int? week1TotalCount;
  int? week1Count;
  int? week2Count;
  int? week2TotalCount;
  int? week3Count;
  int? week3TotalCount;
  int? week4Count;
  int? week4TotalCount;
  int? week5Count;
  int? week5TotalCount;
  int? contractTotalCount;
  int? contractSelectedCount;
  bool? isFullPlanCopied;
  bool? subscriptionOnHold;
  String? holdDate;
  String? unHoldDate;
  int? holdbyuser;
  String? holdREmark;
  int? subscriptonDayNumber;
  double? totalPrice;
  String? shortRemark;
  bool? aCTIVE;
  int? cRUPID;
  String? changesDate;
  int? driverID;
  String? cStatus;
  String? uploadDate;
  String? uploadby;
  String? syncDate;
  String? syncby;
  int? synID;
  String? paymentStatus;
  String? syncStatus;
  int? localID;
  String? offlineStatus;
  String? allergies;
  int? carbs;
  int? protein;
  String? remarks;
  // int lOCATIONID;
  double? totalprice;
  //int cRUPID;

  PlanmealinvoiceHD({
    this.id,
    this.tenentID,
    this.mYTRANSID,
    this.lOCATIONID,
    this.customerID,
    this.planid,
    this.dayNumber,
    this.transID,
    this.contractID,
    this.defaultDriverID,
    this.contractDate,
    this.weekofDay,
    this.startDate,
    this.endDate,
    this.totalAmount,
    this.paidAmount,
    this.allowWeekend,
    this.totalSubDays,
    this.deliveredDays,
    this.nExtDeliveryDate,
    this.nExtDeliveryNum,
    this.week1TotalCount,
    this.week1Count,
    this.week2Count,
    this.week2TotalCount,
    this.week3Count,
    this.week3TotalCount,
    this.week4Count,
    this.week4TotalCount,
    this.week5Count,
    this.week5TotalCount,
    this.contractTotalCount,
    this.contractSelectedCount,
    this.isFullPlanCopied,
    this.subscriptionOnHold,
    this.holdDate,
    this.unHoldDate,
    this.holdbyuser,
    this.holdREmark,
    this.subscriptonDayNumber,
    this.totalPrice,
    this.shortRemark,
    this.aCTIVE,
    this.cRUPID,
    this.changesDate,
    this.driverID,
    this.cStatus,
    this.uploadDate,
    this.uploadby,
    this.syncDate,
    this.syncby,
    this.synID,
    this.paymentStatus,
    this.syncStatus,
    this.localID,
    this.offlineStatus,
    this.allergies,
    this.carbs,
    this.protein,
    this.remarks,
    // this.lOCATIONID,
    this.totalprice,
    // this.cRUPID
  });

  PlanmealinvoiceHD.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    tenentID = json['TenentID'];
    mYTRANSID = json['MYTRANSID'];
    lOCATIONID = json['LOCATION_ID'];
    customerID = json['CustomerID'];
    planid = json['planid'];
    dayNumber = json['DayNumber'];
    transID = json['TransID'];
    contractID = json['ContractID'];
    defaultDriverID = json['DefaultDriverID'];
    contractDate = json['ContractDate'];
    weekofDay = json['WeekofDay'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    totalAmount = json['TotalAmount'];
    paidAmount = json['PaidAmount'];
    allowWeekend = json['AllowWeekend'];
    totalSubDays = json['TotalSubDays'];
    deliveredDays = json['DeliveredDays'];
    nExtDeliveryDate = json['NExtDeliveryDate'];
    nExtDeliveryNum = json['NExtDeliveryNum'];
    week1TotalCount = json['Week1TotalCount'];
    week1Count = json['Week1Count'];
    week2Count = json['Week2Count'];
    week2TotalCount = json['Week2TotalCount'];
    week3Count = json['Week3Count'];
    week3TotalCount = json['Week3TotalCount'];
    week4Count = json['Week4Count'];
    week4TotalCount = json['Week4TotalCount'];
    week5Count = json['Week5Count'];
    week5TotalCount = json['Week5TotalCount'];
    contractTotalCount = json['ContractTotalCount'];
    contractSelectedCount = json['ContractSelectedCount'];
    isFullPlanCopied = json['IsFullPlanCopied'];
    subscriptionOnHold = json['SubscriptionOnHold'];
    holdDate = json['HoldDate'];
    unHoldDate = json['UnHoldDate'];
    holdbyuser = json['Holdbyuser'];
    holdREmark = json['HoldREmark'];
    subscriptonDayNumber = json['SubscriptonDayNumber'];
    totalPrice = json['Total_price'];
    shortRemark = json['ShortRemark'];
    aCTIVE = json['ACTIVE'];
    cRUPID = json['CRUP_ID'];
    changesDate = json['ChangesDate'];
    driverID = json['DriverID'];
    cStatus = json['CStatus'];
    uploadDate = json['UploadDate'];
    uploadby = json['Uploadby'];
    syncDate = json['SyncDate'];
    syncby = json['Syncby'];
    synID = json['SynID'];
    paymentStatus = json['PaymentStatus'];
    syncStatus = json['syncStatus'];
    localID = json['LocalID'];
    offlineStatus = json['OfflineStatus'];
    allergies = json['Allergies'];
    carbs = json['Carbs'];
    protein = json['Protein'];
    remarks = json['Remarks'];
    lOCATIONID = json['LOCATIONID'];
    totalprice = json['Totalprice'];
    cRUPID = json['CRUPID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['TenentID'] = this.tenentID;
    data['MYTRANSID'] = this.mYTRANSID;
    data['LOCATION_ID'] = this.lOCATIONID;
    data['CustomerID'] = this.customerID;
    data['planid'] = this.planid;
    data['DayNumber'] = this.dayNumber;
    data['TransID'] = this.transID;
    data['ContractID'] = this.contractID;
    data['DefaultDriverID'] = this.defaultDriverID;
    data['ContractDate'] = this.contractDate;
    data['WeekofDay'] = this.weekofDay;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['TotalAmount'] = this.totalAmount;
    data['PaidAmount'] = this.paidAmount;
    data['AllowWeekend'] = this.allowWeekend;
    data['TotalSubDays'] = this.totalSubDays;
    data['DeliveredDays'] = this.deliveredDays;
    data['NExtDeliveryDate'] = this.nExtDeliveryDate;
    data['NExtDeliveryNum'] = this.nExtDeliveryNum;
    data['Week1TotalCount'] = this.week1TotalCount;
    data['Week1Count'] = this.week1Count;
    data['Week2Count'] = this.week2Count;
    data['Week2TotalCount'] = this.week2TotalCount;
    data['Week3Count'] = this.week3Count;
    data['Week3TotalCount'] = this.week3TotalCount;
    data['Week4Count'] = this.week4Count;
    data['Week4TotalCount'] = this.week4TotalCount;
    data['Week5Count'] = this.week5Count;
    data['Week5TotalCount'] = this.week5TotalCount;
    data['ContractTotalCount'] = this.contractTotalCount;
    data['ContractSelectedCount'] = this.contractSelectedCount;
    data['IsFullPlanCopied'] = this.isFullPlanCopied;
    data['SubscriptionOnHold'] = this.subscriptionOnHold;
    data['HoldDate'] = this.holdDate;
    data['UnHoldDate'] = this.unHoldDate;
    data['Holdbyuser'] = this.holdbyuser;
    data['HoldREmark'] = this.holdREmark;
    data['SubscriptonDayNumber'] = this.subscriptonDayNumber;
    data['Total_price'] = this.totalPrice;
    data['ShortRemark'] = this.shortRemark;
    data['ACTIVE'] = this.aCTIVE;
    data['CRUP_ID'] = this.cRUPID;
    data['ChangesDate'] = this.changesDate;
    data['DriverID'] = this.driverID;
    data['CStatus'] = this.cStatus;
    data['UploadDate'] = this.uploadDate;
    data['Uploadby'] = this.uploadby;
    data['SyncDate'] = this.syncDate;
    data['Syncby'] = this.syncby;
    data['SynID'] = this.synID;
    data['PaymentStatus'] = this.paymentStatus;
    data['syncStatus'] = this.syncStatus;
    data['LocalID'] = this.localID;
    data['OfflineStatus'] = this.offlineStatus;
    data['Allergies'] = this.allergies;
    data['Carbs'] = this.carbs;
    data['Protein'] = this.protein;
    data['Remarks'] = this.remarks;
    data['LOCATIONID'] = this.lOCATIONID;
    data['Totalprice'] = this.totalprice;
    data['CRUPID'] = this.cRUPID;
    return data;
  }
}
