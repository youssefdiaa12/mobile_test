class Trainer {
  String? name;
  String? job;
  String? age;
  String? id;
  String? phoneNumber;
  String? pdf;
  Trainer(this.name, this.job,this.age,this.id,this.phoneNumber ,this.pdf);

  Map<String, dynamic> toFireStore() {

    return {
      'id': id, 'name': name, 'job': job,
      'pdf' : pdf,
      'age': age,
      'phoneNumber': phoneNumber,

    };
  }

  Trainer.fromFireStore(Map<String, dynamic>? mp) {
    id=mp?['id'];
    name=mp?['name'];
    job=mp?['job'];
    pdf=mp?['pdf'];
    age=mp?['age'];
    phoneNumber=mp?['phoneNumber'];
  }

}
