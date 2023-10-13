import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_recognition/domain/entities/food_recognition_ingredients.dart';
import 'package:flutter_food_recognition/infra/repository/food_recognition_repository.dart';
import 'package:flutter_food_recognition_app/presentation/core/app_module.dart';
import 'package:flutter_food_recognition_app/presentation/core/app_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/main/image_choosed_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/main/main.page.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/main/main_body_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/main/main_image_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/main/main_title_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/food_recognition_body_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/image_source/image_source_choose_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/scanner_image/scanner_animation_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/failure/food_recognition_failure_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/failure/food_recognition_show_failure_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/food_recognition_loading_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/result/food_recognition_result_background_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/result/food_recognition_result_data_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/result/food_recognition_result_image_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/result/food_recognition_result_ingredient_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/result/food_recognition_result_no_ingredient_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/result/food_recognition_result_widget.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../flutter_food_recognition/test/data/food_recognition_domain_example.dart';

class MockFoodRecognitionRepository extends Mock implements FoodRecognitionRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockFoodRecognitionRepository mockFoodRecognitionRepository;

  setUpAll(() {
    registerFallbackValue(ImageSource.gallery);
    ImagePickerPlatform.instance = FakeImagePicker();
    mockFoodRecognitionRepository = MockFoodRecognitionRepository();
    Modular
      ..init(AppModule())
      ..bindModule(AppModule())
      ..replaceInstance<FoodRecognitionRepository>(mockFoodRecognitionRepository);
  });

  Future<void> mainBodyApp(WidgetTester tester) async {
    await tester.pumpWidget(const AppWidget());
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(MainPage), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(RxRoot), findsOneWidget);
    expect(find.byType(ImageSourceChooseWidget), findsOneWidget);
    await tester.tap(
      find.byKey(const Key('gallery_choose_image_resource_button')),
    );
    expect(find.byType(FoodRecognitionBodyWidget), findsOneWidget);
    expect(find.byType(MainBodyWidget), findsOneWidget);
    expect(find.byType(MainTitleWidget), findsOneWidget);
    expect(find.byType(MainImageWidget), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    expect(find.byType(FoodRecognitionLoadingWidget), findsOneWidget);
    expect(find.byType(MainTitleWidget), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
    expect(find.byType(ImageChoosedWidget), findsOneWidget);
    expect(find.byType(ScannerWidget), findsWidgets);
    await tester.pumpAndSettle();
  }

  void setUpMockResult(Result<FoodRecognitionIngredients, CoreFailure> result) {
    when(() => mockFoodRecognitionRepository.getImageRecognition(any())).thenAnswer(
      (_) async {
        await Future.delayed(const Duration(seconds: 10));

        return result;
      },
    );
  }

  group('Search done |', () {
    Future<void> setupMockSearchBody(WidgetTester tester) async {
      expect(find.byType(FoodRecognitionResultWidget), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 8));
      expect(find.byType(MainTitleWidget), findsOneWidget);
      expect(find.byType(FoodRecognitionResultBackgroundWidget), findsOneWidget);
      expect(find.byType(FoodRecognitionResultImageWidget), findsOneWidget);
      expect(find.byType(ImageChoosedWidget), findsOneWidget);
      expect(find.byType(FoodRecognitionResultDataWidget), findsOneWidget);
      expect(find.byType(FoodRecognitionFailureWidget), findsNothing);
    }

    testWidgets(
      'Should test main title, load and success widget when gallery image is successfully recognized',
      (tester) async {
        setUpMockResult(Result.success(FoodRecognitionIngredients(foodRecognitionDomain)));
        await mainBodyApp(tester);
        await setupMockSearchBody(tester);
        expect(find.byType(GridView), findsOneWidget);
        expect(find.byType(FoodRecognitionResultIngredientWidget), findsWidgets);
      },
    );

    testWidgets(
      'Should main title, load and success widget when gallery image is not successfully recognized',
      (tester) async {
        setUpMockResult(Result.success(FoodRecognitionIngredients(List.empty())));
        await mainBodyApp(tester);
        await setupMockSearchBody(tester);
        expect(find.byType(FoodRecognitionNoIngredientWidget), findsOneWidget);
      },
    );
  });

  group('Search failure |', () {
    Future<void> failureBody(WidgetTester tester) async {
      await mainBodyApp(tester);
      expect(find.byType(FoodRecognitionResultWidget), findsNothing);
      expect(find.byType(FoodRecognitionFailureWidget), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 8));
      expect(find.byType(FoodRecognitionShowFailureWidget), findsOneWidget);
      expect(find.byType(MainTitleWidget), findsOneWidget);
    }

    Future<void> verifyFailureImage(String imagePath) async {
      await rootBundle.load(imagePath);
      expect(
        find.widgetWithImage(
          SizedBox,
          AssetImage(imagePath),
        ),
        findsOneWidget,
      );
    }

    void verifyFailureMessage(String message) {
      expect(
        find.text(message),
        findsOneWidget,
      );
    }

    testWidgets('Should show connection failure screen', (tester) async {
      setUpMockResult(Result.failure(const ConnectionFailure()));
      await failureBody(tester);
      await verifyFailureImage('assets/images/failure/connection_failure.png');
      verifyFailureMessage('Por favor, verifique a conexão de internet do seu dispositivo.');
    });

    testWidgets('Should show authentication credentials failure screen', (tester) async {
      setUpMockResult(Result.failure(const AuthenticationCredentialsFailure()));
      await failureBody(tester);
      await verifyFailureImage('assets/images/failure/authentication_credentials_failure.png');
      verifyFailureMessage(
        'Erro no acesso ao serviço de reconhecimento. Tente novamente, por favor.',
      );
    });

    testWidgets('Should show unexpected http failure screen', (tester) async {
      setUpMockResult(Result.failure(const UnexpectedHttpFailure()));
      await failureBody(tester);
      await verifyFailureImage('assets/images/failure/unexpected_http_failure.png');
      verifyFailureMessage('Erro no serviço de reconhecimento. Tente novamente, por favor.');
    });

    testWidgets('Should show response http failure screen', (tester) async {
      setUpMockResult(Result.failure(const ResponseHttpFailure()));
      await failureBody(tester);
      await verifyFailureImage('assets/images/failure/response_http_failure.png');
      verifyFailureMessage(
        'Erro no retorno das informações do serviço de reconhecimento. Tente novamente, por favor.',
      );
    });
  });
}

class FakeImagePicker extends ImagePickerPlatform {
  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    final imageFileData = await rootBundle.load('assets/images/food_image_example.jpg');
    final bytes = imageFileData.buffer.asUint8List(
      imageFileData.offsetInBytes,
      imageFileData.lengthInBytes,
    );
    final Directory tmpDir = await getTemporaryDirectory();
    final file = File('${tmpDir.path}food_image_example.jpg');
    await file.writeAsBytes(bytes);

    return XFile(source == ImageSource.camera ? 'cameraImage' : file.path);
  }
}
