class ChatRoomModel {
  bool? error;
  String? message;
  Data? data;

  ChatRoomModel({this.error, this.message, this.data});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {

  LastMessage? lastMessage;


  Data(
      {
        this.lastMessage,
     });

  Data.fromJson(Map<String, dynamic> json) {

    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    return data;
  }
}

class LastMessage {
  int? chatId;
  LastMessage(
      {this.chatId,
        });

  LastMessage.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['chat_id'] = this.chatId;
    return data;
  }
}




