
import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/feature/notification/domain/entities/notification_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    required BuildContext context,
  });

  Future<Either<Failure, void>> markAsRead({
    required BuildContext context,
    required int notificationId,
  });
}
