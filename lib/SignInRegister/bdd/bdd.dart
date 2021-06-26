class Utilisateur {
  String name;
  // The user's first name (prenom)
  String userFullName;
  // The user's phone number

  String email;
  // The user's address

  String password;
  // The user id that will differentiate between all the users
  String id;
  // The url of the user's profile pic
  String imageURL;
  // User Type (doctor or patient)

  Utilisateur({
     this.name,
    this.userFullName,
     this.email,
     this.imageURL,
     this.password,
    this.id,
  });
}
