class DoctorListObj {
  PersonalDetails personalDetails;
  ProfesionalDetails profesionalDetails;
  VerifyStatus verifyStatus;

  DoctorListObj(
      {this.personalDetails, this.profesionalDetails, this.verifyStatus});

  DoctorListObj.fromJson(Map<String, dynamic> json) {
    personalDetails = json['personalDetails'] != null
        ? new PersonalDetails.fromJson(json['personalDetails'])
        : null;
    profesionalDetails = json['profesionalDetails'] != null
        ? new ProfesionalDetails.fromJson(json['profesionalDetails'])
        : null;
    verifyStatus = json['verifyStatus'] != null
        ? new VerifyStatus.fromJson(json['verifyStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalDetails != null) {
      data['personalDetails'] = this.personalDetails.toJson();
    }
    if (this.profesionalDetails != null) {
      data['profesionalDetails'] = this.profesionalDetails.toJson();
    }
    if (this.verifyStatus != null) {
      data['verifyStatus'] = this.verifyStatus.toJson();
    }
    return data;
  }
}

class PersonalDetails {
  String address;
  String dob;
  String email;
  String fatherName;
  String name;
  bool data;
  String imageUrl;
  String uid;

  PersonalDetails(
      {this.address,
      this.dob,
      this.email,
      this.fatherName,
      this.name,
      this.imageUrl,
      this.uid,
      this.data});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    address = json['Address'];
    dob = json['Dob'];
    email = json['Email'];
    fatherName = json['FatherName'];
    name = json['Name'];
    data = json['data'];
    imageUrl = json['imageUrl'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Address'] = this.address;
    data['Dob'] = this.dob;
    data['Email'] = this.email;
    data['FatherName'] = this.fatherName;
    data['Name'] = this.name;
    data['data'] = this.data;
    data['imageUrl'] = this.imageUrl;
    data['uid'] = this.uid;
    return data;
  }
}

class ProfesionalDetails {
  List<String> qulifications;
  String regNumber;
  String uniName;
  String yearOfReg;
  bool data;

  ProfesionalDetails(
      {this.qulifications,
      this.regNumber,
      this.uniName,
      this.yearOfReg,
      this.data});

  ProfesionalDetails.fromJson(Map<String, dynamic> json) {
    qulifications = json['Qulifications'].cast<String>();
    regNumber = json['RegNumber'];
    uniName = json['UniName'];
    yearOfReg = json['YearOfReg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Qulifications'] = this.qulifications;
    data['RegNumber'] = this.regNumber;
    data['UniName'] = this.uniName;
    data['YearOfReg'] = this.yearOfReg;
    data['data'] = this.data;
    return data;
  }
}

class VerifyStatus {
  bool isVerify;

  VerifyStatus({this.isVerify});

  VerifyStatus.fromJson(Map<String, dynamic> json) {
    isVerify = json['isVerify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerify'] = this.isVerify;
    return data;
  }
}
