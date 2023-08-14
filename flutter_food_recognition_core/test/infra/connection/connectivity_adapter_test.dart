import 'package:flutter_food_recognition_core/infra/connection/connectivity_adapter.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  late ConnectivityAdapter connectivityAdapter;

  setUpAll(() {
    mockConnectivity = MockConnectivity();
    connectivityAdapter = ConnectivityAdapter(
      connectivity: mockConnectivity,
    );
  });

  group('Internet Connection Adapter | isConnected |', () {
    void setUpMockCheckConnection(ConnectivityResult connectionResult) {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => connectionResult,
      );
    }

    test('Should return true if there is internet connection', () async {
      setUpMockCheckConnection(ConnectivityResult.mobile);
      final isConnected = await connectivityAdapter.isConnected();
      expect(isConnected, isA<bool>());
      expect(isConnected, isTrue);
    });

    test('Should return false if there is no internet connection', () async {
      setUpMockCheckConnection(ConnectivityResult.none);
      final isConnected = await connectivityAdapter.isConnected();
      expect(isConnected, isA<bool>());
      expect(isConnected, isFalse);
    });
  });
}
