import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class NyumbaFirebaseUser {
  NyumbaFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

NyumbaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<NyumbaFirebaseUser> nyumbaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<NyumbaFirebaseUser>((user) => currentUser = NyumbaFirebaseUser(user));
