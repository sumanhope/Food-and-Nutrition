import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/tzdata.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      ),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(
      id,
      title,
      body,
      await _notificationsDetails(),
      payload: payload,
    );
  }

  // static Future showScheduleNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payload,
  //   required DateTime scheduleDate,
  // }) async {
  //   var tz;
  //   _notifications.zonedSchedule(
  //       id, title, body, _scheduleDaily(Time(8)), await _notificationsDetails(),
  //       payload: payload,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time);
  // }
}
