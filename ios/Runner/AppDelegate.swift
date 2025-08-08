import Firebase
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)

        // this
        SwiftFlutterForegroundTaskPlugin.setPluginRegistrantCallback {
            registry in
            GeneratedPluginRegistrant.register(with: registry)
        }
   
        return super.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }

    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
        print("Token: \(deviceToken)")
    }

    override func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        print("📥 背景點通知 userInfo: \(userInfo)")

        if let data = userInfo["alertDialog"] as? String {
            if let controller = window?.rootViewController
                as? FlutterViewController
            {
                let channel = FlutterMethodChannel(
                    name: "firebase_notifications",
                    binaryMessenger: controller.binaryMessenger
                )
                DispatchQueue.main.async {
                    channel.invokeMethod("alertDialog", arguments: data)
                }
            }
        }

        completionHandler()
    }

    override func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        print("📲 前景通知收到 userInfo: \(userInfo)")

        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(
                name: "firebase_notifications",
                binaryMessenger: controller.binaryMessenger
            )

            if let data = userInfo["alertDialog"] as? String {
                DispatchQueue.main.async {
                    channel.invokeMethod("alertDialog", arguments: data)
                }
            }
        }

        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound, .badge])
        } else {
            completionHandler([.sound, .badge])
        }
    }
}
