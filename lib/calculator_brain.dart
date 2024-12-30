import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final int height;
  final int weight;
  late double _bmi;

  String calculateBMI(int height, int weight) {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 30) {
      return 'Obese';
    } else if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 30) {
      return '\n You have a higher than normal body weight. It is recommended to focus on a balanced diet and increase physical activity.\n'
          '    1. Engage in at least 30 minutes of moderate exercise, such as walking or swimming, 5 days a week.\n'
          '    2. Reduce your intake of high-calorie, sugary, and processed foods.\n'
          '    3. Stay hydrated by drinking plenty of water throughout the day.\n';
    } else if (_bmi > 25) {
      return '\n You are overweight. Regular physical activity and a balanced diet can help you return to a healthy weight.\n'
          '    1. Aim for 150 minutes of moderate aerobic exercise weekly, such as cycling or jogging.\n'
          '    2. Include more vegetables, fruits, and whole grains in your daily meals.\n'
          '    3. Stay hydrated and avoid excessive snacking on junk or processed foods.\n';
    } else if (_bmi > 18.5) {
      return '\n You have a normal body weight. Keep up the good work and maintain a healthy lifestyle.\n'
          '    1. Continue regular physical activity to maintain your weight.\n'
          '    2. Follow a balanced diet with fruits, vegetables, and proteins.\n'
          '    3. Stay active and go for regular health checkups.\n';
    } else {
      return '\n You have a lower than normal body weight. It might help to increase your calorie intake and focus on building strength.\n'
          '    1. Include protein-rich foods like eggs, beans, and meats in your meals.\n'
          '    2. Focus on strength training to build muscle mass.\n'
          '    3. Avoid skipping meals and eat smaller portions frequently.\n';
    }
  }
}
