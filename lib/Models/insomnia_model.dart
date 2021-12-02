// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);


import 'dart:convert';
import 'package:http/http.dart' as http;


//UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

//String userDataToJson(UserData data) => json.encode(data.toJson());

Future<List<Datum>> fetchUserData() async{
  final response = await http.get(Uri.parse("http://18.216.171.213:3000/api/v1/feedback-process"));
  if(response.statusCode==200)

    {
      final jsonResponse =json.decode(response.body);
      final userdataList=jsonResponse['message'] as List;
      return userdataList.map((data) => Datum.fromJson(data)).toList();


    }
  else{
    throw Exception("Failed to load the data");
  }
}






class UserData {
  UserData({
    required this.data,
    required this.status,
    required this.message,
  });

  final List<Datum> data;
  final String status;
  final String message;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.recipient,
    required this.status,
    required this.description,
    required this.audioLink,
    required this.resultVisibility,
    required this.otherUserRequest,
    required this.otherUserRequestAuto,
    required this.otherUserRequestPassword,
    required this.giversInvited,
    required this.givers,
    required this.anonymousGivers,
    required this.openRequests,
    required this.step,
    required this.slug,
    required this.identifier,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.password,
    required this.elements,
  });

  final String id;
  final Recipient recipient;
  final String status;
  final String description;
  final String audioLink;
  final bool resultVisibility;
  final bool otherUserRequest;
  final bool otherUserRequestAuto;
  final bool otherUserRequestPassword;
  final List<dynamic> giversInvited;
  final List<String> givers;
  final List<String> anonymousGivers;
  final List<dynamic> openRequests;
  final int step;
  final String slug;
  final String identifier;
  final String owner;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String password;
  final List<Element> elements;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    recipient: Recipient.fromJson(json["recipient"]),
    status: json["status"],
    description: json["description"],
    audioLink: json["audioLink"],
    resultVisibility: json["resultVisibility"],
    otherUserRequest: json["otherUserRequest"],
    otherUserRequestAuto: json["otherUserRequestAuto"],
    otherUserRequestPassword: json["otherUserRequestPassword"],
    giversInvited: List<dynamic>.from(json["giversInvited"].map((x) => x)),
    givers: List<String>.from(json["givers"].map((x) => x)),
    anonymousGivers: List<String>.from(json["anonymousGivers"].map((x) => x)),
    openRequests: List<dynamic>.from(json["openRequests"].map((x) => x)),
    step: json["step"],
    slug: json["slug"],
    identifier: json["identifier"],
    owner: json["owner"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    password: json["password"],
    elements: List<Element>.from(json["elements"].map((x) => Element.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "recipient": recipient.toJson(),
    "status": status,
    "description": description,
    "audioLink": audioLink,
    "resultVisibility": resultVisibility,
    "otherUserRequest": otherUserRequest,
    "otherUserRequestAuto": otherUserRequestAuto,
    "otherUserRequestPassword": otherUserRequestPassword,
    "giversInvited": List<dynamic>.from(giversInvited.map((x) => x)),
    "givers": List<dynamic>.from(givers.map((x) => x)),
    "anonymousGivers": List<dynamic>.from(anonymousGivers.map((x) => x)),
    "openRequests": List<dynamic>.from(openRequests.map((x) => x)),
    "step": step,
    "slug": slug,
    "identifier": identifier,
    "owner": owner,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "password": password,
    "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
  };
}

class Element {
  Element({
    required this.id,
    required this.isWatched,
    required this.identifier,
    required this.position,
  });

  final String id;
  final bool isWatched;
  final String identifier;
  final int position;

  factory Element.fromJson(Map<String, dynamic> json) => Element(
    id: json["_id"],
    isWatched: json["isWatched"],
    identifier: json["identifier"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isWatched": isWatched,
    "identifier": identifier,
    "position": position,
  };
}

class Recipient {
  Recipient({
    required this.invitation,
    required this.userId,
    required this.username,
  });

  final String invitation;
  final String userId;
  final String username;

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    invitation: json["invitation"],
    userId: json["userId"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "invitation": invitation,
    "userId": userId,
    "username": username,
  };
}
