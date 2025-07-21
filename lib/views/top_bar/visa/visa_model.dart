// visa_model.dart
class VisaModel {
  final String id;
  final String title;
  final String description;
  final String country;
  final String duration;
  final String entryType;
  final String processingTime;
  final double price;
  final String currency;
  final String imageUrl;
  final List<String> requirements;
  final bool isTransit;

  VisaModel({
    required this.id,
    required this.title,
    required this.description,
    required this.country,
    required this.duration,
    required this.entryType,
    required this.processingTime,
    required this.price,
    required this.currency,
    required this.imageUrl,
    required this.requirements,
    this.isTransit = false,
  });

  factory VisaModel.fromJson(Map<String, dynamic> json) {
    return VisaModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      country: json['country'] ?? '',
      duration: json['duration'] ?? '',
      entryType: json['entryType'] ?? '',
      processingTime: json['processingTime'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'PKR',
      imageUrl: json['imageUrl'] ?? '',
      requirements: List<String>.from(json['requirements'] ?? []),
      isTransit: json['isTransit'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'country': country,
      'duration': duration,
      'entryType': entryType,
      'processingTime': processingTime,
      'price': price,
      'currency': currency,
      'imageUrl': imageUrl,
      'requirements': requirements,
      'isTransit': isTransit,
    };
  }
}

// visa_application_model.dart
class VisaApplicationModel {
  final String id;
  final String visaId;
  final int numberOfAdults;
  final int numberOfChildren;
  final List<PassengerModel> passengers;
  final BookerModel booker;
  final double totalFee;
  final String status;
  final DateTime applicationDate;
  final DateTime? processedDate;

  VisaApplicationModel({
    required this.id,
    required this.visaId,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.passengers,
    required this.booker,
    required this.totalFee,
    required this.status,
    required this.applicationDate,
    this.processedDate,
  });

  factory VisaApplicationModel.fromJson(Map<String, dynamic> json) {
    return VisaApplicationModel(
      id: json['id'] ?? '',
      visaId: json['visaId'] ?? '',
      numberOfAdults: json['numberOfAdults'] ?? 0,
      numberOfChildren: json['numberOfChildren'] ?? 0,
      passengers: (json['passengers'] as List<dynamic>?)
          ?.map((e) => PassengerModel.fromJson(e))
          .toList() ?? [],
      booker: BookerModel.fromJson(json['booker'] ?? {}),
      totalFee: (json['totalFee'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      applicationDate: DateTime.parse(json['applicationDate']),
      processedDate: json['processedDate'] != null 
          ? DateTime.parse(json['processedDate']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visaId': visaId,
      'numberOfAdults': numberOfAdults,
      'numberOfChildren': numberOfChildren,
      'passengers': passengers.map((e) => e.toJson()).toList(),
      'booker': booker.toJson(),
      'totalFee': totalFee,
      'status': status,
      'applicationDate': applicationDate.toIso8601String(),
      'processedDate': processedDate?.toIso8601String(),
    };
  }
}

// passenger_model.dart
class PassengerModel {
  final String id;
  final String firstName;
  final String lastName;
  final String passportNumber;
  final String? documentPath;
  final bool isAdult;
  final double price;

  PassengerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.passportNumber,
    this.documentPath,
    required this.isAdult,
    required this.price,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      passportNumber: json['passportNumber'] ?? '',
      documentPath: json['documentPath'],
      isAdult: json['isAdult'] ?? true,
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'passportNumber': passportNumber,
      'documentPath': documentPath,
      'isAdult': isAdult,
      'price': price,
    };
  }
}

// booker_model.dart
class BookerModel {
  final String name;
  final String email;
  final String phone;

  BookerModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory BookerModel.fromJson(Map<String, dynamic> json) {
    return BookerModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}