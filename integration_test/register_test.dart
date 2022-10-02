import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/consts/mykeys.dart';
import 'package:integration_test/integration_test.dart';
import 'package:grocery_app/main.dart' as myapp;

void main() {
  group("Regester Screen Test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    //Test Case
    testWidgets("Regest Screen", (tester) async {
      myapp.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final emailReg = find.byKey(const Key(MyKeys.EMAILREG));
      final nameReg = find.byKey(const Key(MyKeys.NAMEREG));
      final passReg = find.byKey(const Key(MyKeys.PASSWORDREG));
      final addressReg = find.byKey(const Key(MyKeys.ADDRESSREG));
      final signUp = find.byKey(const Key(MyKeys.SIGNUP_BUTTON));
      await tester.enterText(emailReg, "test@example.com");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(nameReg, "Test Name");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(passReg, "coding@1234?");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(addressReg, "Palestine");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(signUp);
    });
  });
}
