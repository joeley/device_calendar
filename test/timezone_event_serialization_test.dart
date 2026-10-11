import 'package:device_calendar/device_calendar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;

void main() {
  setUpAll(tz_data.initializeTimeZones);

  test('Event_Serializes_Dst_Overlap_And_None_Status', () {
    final location = getLocation('America/New_York');
    final start = TZDateTime.from(DateTime.utc(2026, 11, 1, 6, 30), location);
    final end = TZDateTime.from(DateTime.utc(2026, 11, 1, 7, 30), location);
    final event = Event(
      'calendarId',
      start: start,
      end: end,
      status: EventStatus.None,
    );

    final restored = Event.fromJson(event.toJson());

    expect(restored.start!.toUtc(), DateTime.utc(2026, 11, 1, 6, 30));
    expect(restored.end!.toUtc(), DateTime.utc(2026, 11, 1, 7, 30));
    expect(restored.start!.location.name, 'America/New_York');
    expect(restored.status, EventStatus.None);
  });
}
