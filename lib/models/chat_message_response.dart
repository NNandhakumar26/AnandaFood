import 'package:intl/intl.dart';

class ChatMessageResponse {
  String? id;
  List<ChatMessageModel>? chatMessageModel;
  String? message;
  int? status;
  bool? success;
  int? recordCount;

  ChatMessageResponse(
      {this.id,
      this.chatMessageModel,
      this.message,
      this.status,
      this.success,
      this.recordCount});

  ChatMessageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      chatMessageModel = [];
      json['data'].forEach((v) {
        chatMessageModel!.add(new ChatMessageModel.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
    success = json['success'];
    recordCount = json['RecordCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    if (this.chatMessageModel != null) {
      data['data'] = this.chatMessageModel!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    data['success'] = this.success;
    data['RecordCount'] = this.recordCount;
    return data;
  }
}

class ChatMessageModel {
  String? id;
  int? tenentID;
  int? lOCATIONID;
  int? customerID;
  String? messageId;
  String? usermessage;
  String? senderUserId;
  String? messageFor;
  String? receiverUserId;
  String? messageTime;
  String? syncStatus;
  String? updateDate;
  String? cStatus;
  String? messageReadDate;

  DateTime? messageTimeDate;

  ChatMessageModel({
    this.id,
    this.tenentID,
    this.lOCATIONID,
    this.customerID,
    this.messageId,
    this.usermessage,
    this.senderUserId,
    this.messageFor,
    this.receiverUserId,
    this.messageTime,
    this.syncStatus,
    this.updateDate,
    this.cStatus,
    this.messageReadDate,
  });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenentID = json['TenentID'];
    lOCATIONID = json['LOCATION_ID'];
    customerID = json['CustomerID'];
    messageId = json['message_id'];
    usermessage = json['usermessage'];
    senderUserId = json['sender_user_id'];
    messageFor = json['message_for'];
    receiverUserId = json['receiver_user_id'];
    messageTime = json['message_time'];
    syncStatus = json['syncStatus'];
    updateDate = json['UpdateDate'];
    cStatus = json['CStatus'];
    messageReadDate = json['MessageReadDate'];
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss", "en-US");
    messageTimeDate = dateFormat.parse(messageTime!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = this.id;
    data['TenentID'] = this.tenentID;
    data['LOCATION_ID'] = this.lOCATIONID;
    data['CustomerID'] = this.customerID;
    data['message_id'] = this.messageId;
    data['usermessage'] = this.usermessage;
    data['sender_user_id'] = this.senderUserId;
    data['message_for'] = this.messageFor;
    data['receiver_user_id'] = this.receiverUserId;
    data['message_time'] = this.messageTime;
    data['syncStatus'] = this.syncStatus;
    data['UpdateDate'] = this.updateDate;
    data['CStatus'] = this.cStatus;
    data['MessageReadDate'] = this.messageReadDate;
    return data;
  }
}
