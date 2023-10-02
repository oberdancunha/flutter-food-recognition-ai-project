import 'package:flutter/material.dart';
import 'package:flutter_food_recognition_core/failure/core_failures.dart';

import 'food_recognition_show_failure_widget.dart';

class FoodRecognitionFailureWidget extends StatelessWidget {
  final CoreFailure failure;

  const FoodRecognitionFailureWidget({
    required this.failure,
    super.key,
  });

  @override
  Widget build(BuildContext context) => switch (failure) {
        ConnectionFailure() => const FoodRecognitionShowFailureWidget(
            image: 'connection_failure.png',
            message: 'Por favor, verifique a conexão de internet do seu dispositivo.',
          ),
        AuthenticationCredentialsFailure() => const FoodRecognitionShowFailureWidget(
            image: 'authentication_credentials_failure.png',
            message: 'Erro no acesso ao serviço de reconhecimento. Tente novamente, por favor.',
          ),
        UnexpectedHttpFailure() => const FoodRecognitionShowFailureWidget(
            image: 'unexpected_http_failure.png',
            message: 'Erro no serviço de reconhecimento. Tente novamente, por favor.',
          ),
        ResponseHttpFailure() => const FoodRecognitionShowFailureWidget(
            image: 'response_http_failure.png',
            message:
                'Erro no retorno das informações do serviço de reconhecimento. Tente novamente, por favor.',
          ),
      };
}
