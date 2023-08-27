import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_recognition/infra/gateway/food_recognition_gateway.dart';
import 'package:flutter_food_recognition_app/presentation/core/app_module.dart';
import 'package:flutter_food_recognition_app/presentation/core/app_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/food_recognition_page.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/food_recognition_body_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/image_source/image_source_choose_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/main_title_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/food_recognition_error_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/food_recognition_loading_widget.dart';
import 'package:flutter_food_recognition_app/presentation/food_recognition/widgets/search/food_recognition_result_widget.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../flutter_food_recognition/test/data/food_recognition_domain_example.dart';

class MockFoodRecognitionGateway extends Mock implements FoodRecognitionGateway {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockFoodRecognitionGateway mockFoodRecognitionGateway;

  setUpAll(() {
    registerFallbackValue(ImageSource.gallery);
    ImagePickerPlatform.instance = FakeImagePicker();
    mockFoodRecognitionGateway = MockFoodRecognitionGateway();
    Modular
      ..init(AppModule())
      ..bindModule(AppModule())
      ..replaceInstance<FoodRecognitionGateway>(mockFoodRecognitionGateway);
  });

  Future<void> mainBodyApp(WidgetTester tester) async {
    await tester.pumpWidget(const AppWidget());
    await tester.pump();
    expect(find.byType(FoodRecognitionPage), findsOneWidget);
    expect(find.byType(RxRoot), findsOneWidget);
    expect(find.byType(ImageSourceChooseWidget), findsOneWidget);
    await tester.tap(
      find.byKey(const Key('gallery_choose_image_resource_button')),
    );
    expect(find.byType(FoodRecognitionBodyWidget), findsOneWidget);
    expect(find.byType(MainTitleWidget), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    expect(find.byType(FoodRecognitionLoadingWidget), findsOneWidget);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Should test main title, load and success widget when gallery image is successfully recognized',
    (tester) async {
      when(() => mockFoodRecognitionGateway.getImageRecognition(any())).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 5));

        return Result.success(foodRecognitionDomain.toImmutableList());
      });

      await mainBodyApp(tester);
      expect(find.byType(FoodRecognitionResultWidget), findsOneWidget);
      expect(find.byType(FoodRecognitionErrorWidget), findsNothing);
    },
  );

  testWidgets(
    'Should main title, load and success widget when gallery image is not successfully recognized',
    (tester) async {
      when(() => mockFoodRecognitionGateway.getImageRecognition(any())).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 5));

        return Result.failure(const UnexpectedHttpFailure());
      });

      await mainBodyApp(tester);
      expect(find.byType(FoodRecognitionResultWidget), findsNothing);
      expect(find.byType(FoodRecognitionErrorWidget), findsOneWidget);
    },
  );
}

class FakeImagePicker extends ImagePickerPlatform {
  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    final imageFileData = await rootBundle.load('assets/images/food_image_example.jpeg');
    final bytes = imageFileData.buffer.asUint8List(
      imageFileData.offsetInBytes,
      imageFileData.lengthInBytes,
    );
    final Directory tmpDir = await getTemporaryDirectory();
    final file = File('${tmpDir.path}food_image_example.jpeg');
    await file.writeAsBytes(bytes);

    return XFile(source == ImageSource.camera ? 'cameraImage' : file.path);
  }
}
