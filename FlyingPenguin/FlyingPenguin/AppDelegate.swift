//
//  AppDelegate.swift
//  FlyingPenguin
//  Copyright © 2018 iFiero. All rights reserved.
//

import UIKit
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let urlStr = "http://47.244.241.125:9010/app/check/update?version=7&app_id=1493375397&sign=4ba6863bcefc7c8c04f4369c3f7ca972"
        Alamofire.request(urlStr).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                let jsonData:NSDictionary = json as! NSDictionary
                let dataDict:NSDictionary = jsonData.value(forKey: "data") as! NSDictionary
                if dataDict.count != 0 {
                    let open_status : NSInteger = dataDict.value(forKey: "open_status") as! NSInteger
                    if (open_status == 1) {
                        let web_url = dataDict.value(forKey: "web_url");
                        let url : URL? = URL.init(string: web_url as! String)
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                }
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}

