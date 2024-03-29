import 'dart:async';

import 'package:app_social/blocs/auth/auth_bloc.dart';
import 'package:app_social/models/models.dart';
import 'package:app_social/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _notificationRepository;
  final AuthBloc _authBloc;

  StreamSubscription<List<Future<Notif>>> _notificationsSubscription;

  NotificationsBloc({
    @required NotificationRepository notificationRepository,
    @required AuthBloc authBloc,
  })  : _notificationRepository = notificationRepository,
        _authBloc = authBloc,
        super(NotificationsState.initial()) {
    _notificationsSubscription?.cancel();
    _notificationsSubscription = _notificationRepository
        .getUserNotifications(userId: _authBloc.state.user.uid)
        .listen((notifications) async {
      final allNotifications = await Future.wait(notifications);
      add(NotificationsUpdateNotifications(notifications: allNotifications));
    });
  }

  @override
  Future<void> close() {
    _notificationsSubscription.cancel();
    return super.close();
  }

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is NotificationsUpdateNotifications) {
      yield* _mapNotificationsUpdateNotificationsToState(event);
    }
  }

  Stream<NotificationsState> _mapNotificationsUpdateNotificationsToState(
      NotificationsUpdateNotifications event) async* {
    yield state.copyWith(
      notifications: event.notifications,
      status: NotificationsStatus.loaded,
    );
  }
}
