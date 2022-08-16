import 'package:chicken_game/app/app.dart';
import 'package:chicken_game/game/game.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await di.initializeDependencies();
  });

  tearDown(() async {
    await di.injector.reset();
  });

  group('App', () {
    testWidgets('renders ChickenGamePage', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(const App());
        await tester.pump();

        expect(find.byType(ChickenGamePage), findsOneWidget);
      });
    });
  });
}
