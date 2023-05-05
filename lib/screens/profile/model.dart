class Profile {
  late int id;
  late int unCompletedShifts;
  late String imageUrl;
  late int completedShifts;
  late String firstName;
  late String lastName;
  late String email;
  late String phoneNumber;
  late String? qualificationType;
  late String? address;
  late String? city;
  late String? state;
  late String? zipCode;
  Profile({required this.id,required this.email,required this.address,required this.city, required this.completedShifts,
    required this.firstName,required this.lastName,required this.phoneNumber,required this.qualificationType,
    required this.state,required this.unCompletedShifts,required this.zipCode, required this.imageUrl
  });
  static Profile fromJson(dynamic data ){
    return Profile(id: data['id'], email: data['email'],
        imageUrl: data['image_url'],
        address: data['address'], city: data['city'], completedShifts: data['completed_shifts'],
        firstName: data['first_name'], lastName: data['last_name'], phoneNumber: data['phone_number'],
        qualificationType: data['qualification_type'], state: data['state'], unCompletedShifts: data['unCompleted_shifts'],
        zipCode: data['zip_code']);
  }
}