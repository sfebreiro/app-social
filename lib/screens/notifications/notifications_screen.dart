import 'package:app_social/screens/notifications/bloc/notifications_bloc.dart';
import 'package:app_social/screens/notifications/widgets/widgets.dart';
import 'package:app_social/widgets/centered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notifications';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          switch (state.status) {
            case NotificationsStatus.error:
              return CenteredText(text: state.failure.message);
            case NotificationsStatus.loaded:
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  final notification = state.notifications[index];
                  return NotificationTile(notification: notification);
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
