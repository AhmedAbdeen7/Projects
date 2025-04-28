// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SupabaseConfig {
//   static final SupabaseClient client = Supabase.instance.client;
//   static final RealtimeClient realtime = Supabase.instance.realtime;

//   static Future<void> initialize({
//     required String url,
//     required String key,
//   }) async {
// // Updated Supabase initialization
// await Supabase.initialize(
//   url: 'YOUR_SUPABASE_URL',
//   anonKey: 'YOUR_SUPABASE_ANON_KEY',
//   authOptions: const FlutterAuthClientOptions(
//     authFlowType: AuthFlowType.pkce,
//     redirectUrl: 'yourapp://login-callback', // Moved inside authOptions
//     localStorage: _SecureLocalStorage(),
//   ),
//   realtimeClientOptions: const RealtimeClientOptions( // Renamed parameter
//     logLevel: RealtimeLogLevel.info,
//   ),
// );

// // Access realtime through client
// final realtimeClient = Supabase.instance.client.realtime;

//   }
// }

// class _SecureLocalStorage extends LocalStorage {
//   final _storage = const FlutterSecureStorage();

//   @override
//   Future<void> persistSession(String persistSessionString) async {
//     await _storage.write(
//       key: supabasePersistSessionKey,
//       value: persistSessionString,
//       aOptions: const AndroidOptions(encryptedSharedPreferences: true),
//     );
//   }

//   @override
//   Future<String?> accessToken() async {
//     return _storage.read(
//       key: supabasePersistSessionKey,
//       aOptions: const AndroidOptions(encryptedSharedPreferences: true),
//     );
//   }
// }
