import 'package:intl/intl.dart';

const List<int> kExperienceToLevelRequirements = [
  0, // Level 0
  1000, // Level 1
  4000, // Level 2
  9000, // Level 3
  16000, // Level 4
  25000, // Level 5
  36000, // Level 6
  49000, // Level 7
  64000, // Level 8
  81000, // Level 9
  100000, // Level 10
  121000, // Level 11
  144000, // Level 12
  368000 // Level 13
];

int getLevelFromExp(int experience) {
  final exp = kExperienceToLevelRequirements.reversed.firstWhere((x) => x <= experience);
  final idx = kExperienceToLevelRequirements.indexOf(exp);
  return idx;
}

double calcLevelUpProgress(int experience) {
  final exp = kExperienceToLevelRequirements.reversed.firstWhere((x) => x <= experience);
  final idx = kExperienceToLevelRequirements.indexOf(exp);
  if (idx + 1 >= kExperienceToLevelRequirements.length) return 1;
  final nextExp = kExperienceToLevelRequirements[idx + 1];
  return (experience - exp).abs() / (exp - nextExp).abs();
}

String calcLevelUpProgressLevel(int experience) {
  final exp = kExperienceToLevelRequirements.reversed.firstWhere((x) => x <= experience);
  final idx = kExperienceToLevelRequirements.indexOf(exp);
  if (idx + 1 >= kExperienceToLevelRequirements.length) return 'Infinity';
  final nextExp = exp - kExperienceToLevelRequirements[idx + 1];
  final formatter = NumberFormat.compactCurrency(symbol: '', decimalDigits: 1);
  return '${formatter.format((exp - experience).abs())}/${formatter.format(nextExp.abs())}';
}
