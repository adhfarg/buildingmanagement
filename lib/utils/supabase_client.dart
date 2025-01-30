import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static SupabaseHelper? _instance;
  static late final Supabase _supabase;

  SupabaseHelper._() {
    _supabase = Supabase.instance;
  }

  static SupabaseHelper get instance {
    _instance ??= SupabaseHelper._();
    return _instance!;
  }

  SupabaseClient get client => _supabase.client;

  User? get currentUser => _supabase.client.auth.currentUser;

  Stream<AuthState> get authChanges => _supabase.client.auth.onAuthStateChange;

  Future<void> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    await _supabase.client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _supabase.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _supabase.client.auth.resetPasswordForEmail(email);
  }

  // Add more Supabase-related methods as needed
}
