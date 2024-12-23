import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/userinfo.dart';

// Stored as key: month, day
const Map<String, (int, int)> kSpecialDays = {
  // Birthday is dynamically generated according to the user's profile
  'NewYear': (1, 1),
  'ValentineDay': (2, 14),
  'LaborDay': (5, 1),
  'MotherDay': (5, 11),
  'ChildrenDay': (6, 1),
  'FatherDay': (8, 8),
  'Halloween': (10, 31),
  'Thanksgiving': (11, 28),
  'MerryXmas': (12, 25),
};

const Map<String, String> kSpecialDaysSymbol = {
  'Birthday': '🎂',
  'NewYear': '🎉',
  'MerryXmas': '🎄',
  'ValentineDay': '💑',
  'LaborDay': '🏋️',
  'MotherDay': '👩',
  'ChildrenDay': '👶',
  'FatherDay': '👨',
  'Halloween': '🎃',
  'Thanksgiving': '🎅',
};

class SpecialDayProvider {
  late final UserProvider _user;

  SpecialDayProvider(BuildContext context) {
    _user = context.read<UserProvider>();
  }

  List<String> getSpecialDays() {
    final now = DateTime.now().toLocal();
    final birthday = _user.user?.profile?.birthday?.toLocal();
    final isBirthday = birthday != null && birthday.day == now.day && birthday.month == now.month;

    return [
      if (isBirthday) 'Birthday',
      ...kSpecialDays.keys.where(
        (key) => kSpecialDays[key]!.$1 == now.month && kSpecialDays[key]!.$2 == now.day,
      ),
    ];
  }

  (String, DateTime)? getLastSpecialDay() {
    final now = DateTime.now().toLocal();
    final birthday = _user.user?.profile?.birthday?.toLocal();

    final Map<String, (int, int)> specialDays = {
      if (birthday != null) 'Birthday': (birthday.month, birthday.day),
      ...kSpecialDays,
    };

    DateTime? lastDate;
    String? lastEvent;

    for (final entry in specialDays.entries) {
      final eventName = entry.key;
      final (month, day) = entry.value;

      var specialDayThisYear = DateTime(now.year, month, day);
      var specialDayLastYear = DateTime(now.year - 1, month, day);

      if (specialDayThisYear.isBefore(now)) {
        if (lastDate == null || specialDayThisYear.isAfter(lastDate)) {
          lastDate = specialDayThisYear;
          lastEvent = eventName;
        }
      } else if (specialDayLastYear.isBefore(now)) {
        if (lastDate == null || specialDayLastYear.isAfter(lastDate)) {
          lastDate = specialDayLastYear;
          lastEvent = eventName;
        }
      }
    }

    if (lastEvent != null && lastDate != null) {
      return (lastEvent, lastDate);
    }

    return null;
  }

  (String, DateTime)? getNextSpecialDay() {
    final now = DateTime.now().toLocal();
    final birthday = _user.user?.profile?.birthday?.toLocal();

    // Stored as key: month, day
    final Map<String, (int, int)> specialDays = {
      if (birthday != null) 'Birthday': (birthday.month, birthday.day),
      ...kSpecialDays,
    };

    DateTime? closestDate;
    String? closestEvent;

    for (final entry in specialDays.entries) {
      final eventName = entry.key;
      final (month, day) = entry.value;

      // Calculate the special day's DateTime in the current year
      var specialDay = DateTime(now.year, month, day);

      // If the special day has already passed this year, consider it for the next year
      if (specialDay.isBefore(now)) {
        specialDay = DateTime(now.year + 1, month, day);
      }

      // Check if this special day is closer than the previously found one
      if (closestDate == null || specialDay.isBefore(closestDate)) {
        closestDate = specialDay;
        closestEvent = eventName;
      }
    }

    if (closestEvent != null && closestDate != null) {
      return (closestEvent, closestDate);
    }

    // No special day found
    return null;
  }

  double getSpecialDayProgress(DateTime last, DateTime next) {
    final totalDuration = next.difference(last).inSeconds.toDouble();
    final elapsedDuration = DateTime.now().difference(last).inSeconds.toDouble();
    return (elapsedDuration / totalDuration).clamp(0.0, 1.0);
  }
}
