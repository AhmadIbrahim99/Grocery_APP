import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/consts/mykeys.dart';
import 'package:grocery_app/widgets/auth_button.dart';
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
      // final signUp = find.byKey(const Key(MyKeys.SIGNUP_BUTTON));
      final showPass = find.byKey(const Key(MyKeys.SHOW_PASSOWRD));

      final ss = find.byType(AuthButton).first;
      await tester.enterText(emailReg, "test3@example.com");
      await tester.pumpAndSettle();
      await tester.enterText(nameReg, "Test Name");
      await tester.pumpAndSettle();
      await tester.enterText(passReg, "coding@1234?");
      await tester.pumpAndSettle();
      await tester.enterText(addressReg, "Palestine");
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // await tester.tap(showPass);
      // await tester.pumpAndSettle(const Duration(seconds: 3));
      // await tester.tap(ss);
      // await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
