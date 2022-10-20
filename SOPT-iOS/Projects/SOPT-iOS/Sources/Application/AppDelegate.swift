//
//  AppDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 양수빈 on 2022/10/01.
//

import UIKit
import UserNotifications

import Core

import AWSSNS
import AWSCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // TODO: - 서버한테 받아서 넣기
    private let SNSPlatformApplicationArn = ""
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // APNS 설정
        UNUserNotificationCenter.current().delegate = self
        
        // APNS 권한 허용 알림
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                // APNS 권한 성공
                print("permission granted: \(granted)")
        }
        
        // AWSServiceConfiguration setting
        let defaultServiceConfiguration = AWSServiceConfiguration(region: .APNortheast2, credentialsProvider: nil)
        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration
        
        // APNS 등록
        application.registerForRemoteNotifications()
        return true
    }
    
    /// APNS 등록 실패할 경우 호출되는 메서드
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    
    /// APNS 등록 성공할 경우 호출되는 메서드
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenPart = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenPart.joined()
        print("Device Token:", token)
        
        UserDefaultKeyList.Auth.deviceToken = token
        
        // create platform endpoint (= device endpoint ARN)
        let sns = AWSSNS.default()
        let request = AWSSNSCreatePlatformEndpointInput()
        request?.token = token
        request?.platformApplicationArn = SNSPlatformApplicationArn
        sns.createPlatformEndpoint(request!).continueWith(executor: AWSExecutor.mainThread(), block: { (task: AWSTask!) -> AnyObject? in
            if task.error != nil {
                print("Error: \(String(describing: task.error))")
            } else {
                let createEndpointResponse = task.result! as AWSSNSCreateEndpointResponse
                
                if let endpointArnForSNS = createEndpointResponse.endpointArn {
                    print("endpointArn: \(endpointArnForSNS)")
                    UserDefaultKeyList.Auth.endpointArnForSNS = endpointArnForSNS
                }
            }
            
            return nil
        })
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application( _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application( _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    /// 앱이 실행 중(foreground)에 푸시을 받는 경우 처리하는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound, .badge])
    }
    
    /// background에서 푸시를 받는 경우 처리하는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
