# notification-pusher
Notification pushing service

How it works?

1. You write to /notifications/tosend/queue
2. Cloud trigger triggers this Cloud Run
3. FCM token is fetched from /notification_tokens/{uid}
4. Notification is sent via FCM

Prerequisites:
1. Setup cloud trigger