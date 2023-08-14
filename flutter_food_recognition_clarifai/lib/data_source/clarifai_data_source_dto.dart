import 'package:flutter_food_recognition/domain/entities/food_recognition.dart';
import 'package:flutter_food_recognition_core/data_source/data_source_dto.dart';

class ClarifaiDataSourceDto implements DataSourceDto {
  @override
  List<FoodRecognition> toFoodRecognitionDomain(Map<dynamic, dynamic> dataSourceImageRecognition) {
    try {
      final foodRecognition = <FoodRecognition>[];
      final output = _getDataFromOutputKey(dataSourceImageRecognition);
      final data = _getDataFromDataKey(output);
      final concepts = _getDataListFromConceptsKey(data);
      for (final concept in concepts) {
        final (name, value) = _getNameAndValueFromConceptKey(concept as Map<dynamic, dynamic>);
        if (name.isNotEmpty && value > 0) {
          foodRecognition.add(
            FoodRecognition(
              name: name,
              score: value,
            ),
          );
        }
      }

      return foodRecognition;
    } on Exception catch (_) {
      return [];
    }
  }

  Map<dynamic, dynamic> _getDataFromOutputKey(Map<dynamic, dynamic> dataSourceImageRecognition) {
    if (dataSourceImageRecognition['outputs'] != null) {
      final outputs = dataSourceImageRecognition['outputs'] as List;
      if (outputs.isNotEmpty) {
        return outputs.elementAt(0) as Map<dynamic, dynamic>;
      }
    }

    throw Exception();
  }

  Map<dynamic, dynamic> _getDataFromDataKey(Map<dynamic, dynamic> output) {
    if (output['data'] != null) {
      final data = output['data'] as Map<dynamic, dynamic>;
      if (data.isNotEmpty) {
        return data;
      }
    }

    throw Exception();
  }

  List<dynamic> _getDataListFromConceptsKey(Map<dynamic, dynamic> data) {
    if (data['concepts'] != null) {
      final concepts = data['concepts'] as List;
      if (concepts.isNotEmpty) {
        return concepts;
      }
    }

    throw Exception();
  }

  (String, double) _getNameAndValueFromConceptKey(Map<dynamic, dynamic> concept) {
    const defaultValueWhenError = 0.0;
    if (concept['name'] != null && concept['value'] != null) {
      final name = concept['name'].toString();
      final value = double.tryParse(concept['value'].toString()) ?? defaultValueWhenError;
      return (name, value);
    }

    return ("", defaultValueWhenError);
  }
}
