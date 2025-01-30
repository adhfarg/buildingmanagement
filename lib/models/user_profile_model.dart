import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phoneNumber;
  final String? apartmentNumber;
  final bool receiveNotifications;
  final bool emailUpdates;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNumber,
    this.apartmentNumber,
    this.receiveNotifications = true,
    this.emailUpdates = false,
  });

  String get fullName => '$firstName $lastName';

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'],
      phoneNumber: json['phone_number'],
      apartmentNumber: json['apartment_number'],
      receiveNotifications: json['receive_notifications'] ?? true,
      emailUpdates: json['email_updates'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'apartment_number': apartmentNumber,
      'receive_notifications': receiveNotifications,
      'email_updates': emailUpdates,
    };
  }

  static Future<UserProfile?> getCurrentProfile() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return null;

      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return UserProfile.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<bool> updateProfile() async {
    try {
      await Supabase.instance.client
          .from('profiles')
          .upsert(toJson())
          .eq('id', id);
      return true;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }
}
