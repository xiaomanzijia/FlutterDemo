class UserEmail {
    String email;
    String name;

    UserEmail({this.email, this.name});

    factory UserEmail.fromJson(Map<String, dynamic> json) {
        return UserEmail(
            email: json['email'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['name'] = this.name;
        return data;
    }
}

