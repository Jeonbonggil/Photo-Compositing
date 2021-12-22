//
//  AppDelegate.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/20.
//

import UIKit
import Photos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LibraryVC")
        self.window?.backgroundColor = .clear
        self.window?.makeKeyAndVisible()
        
        // 다크모드 설정되지 않도록 코드 추가
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
    
        return true
    }

}
