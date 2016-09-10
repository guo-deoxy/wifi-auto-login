//
//  AppDelegate.swift
//  myApp
//
//  Created by *** **** on 2016/09/04.
//  Copyright © 2016年 *** ****. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate,MKMapViewDelegate{

    var window: UIWindow?
    
    var viewController:ViewController!
    var mapView:MKMapView!
    var reachability:Reachability!
    var backgroundTaskID: UIBackgroundTaskIdentifier = 0
    var count :integer_t = 0
    var connectTokyoTech:ConnectTokyoTech!
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //startLocationManager();
        connectTokyoTech = ConnectTokyoTech()
        do{
            reachability = try Reachability.reachabilityForInternetConnection()
            
        }catch{
            print("error")
        }
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                if reachability.isReachableViaWiFi() {
                    NSLog("==================================Reachable via WiFi===========================================")
                    self.connectTokyoTech.connectTokyoTech()

                } else {
                    NSLog("Reachable via Cellular")

                }
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                print("Not reachable")
            }
        }
        do{
            try reachability.startNotifier()
        }catch{
            print("error")
        }
        print("launch ok")

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        /*
        self.backgroundTaskID = application.beginBackgroundTaskWithExpirationHandler(){
            [weak self]in
            application.endBackgroundTask((self?.backgroundTaskID)!)
            self?.backgroundTaskID = UIBackgroundTaskInvalid
        }
        */
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDelegate.viewController?.labelField?.text = "go background"
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.viewController.labelField.text = "ok";
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("will enter foreground");
        /*
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.viewController.textField.text = "aaa";
        */

    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //application.endBackgroundTask(self.backgroundTaskID)
        NSLog("active")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.NewData)
    }

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        NSLog("update")
    }
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        NSLog("=================================heading update==================================")
    }
    //ジオフェンスが起動した際に呼び出される
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print("test2")
        
        let circularRegion:CLCircularRegion = region.copy() as! CLCircularRegion
        //ジオフェンスの範囲表示用
        let center:CLLocationCoordinate2D = CLLocationCoordinate2DMake(circularRegion.center.latitude,circularRegion.center.longitude)
        //アノテーション表示用設定
        let myPin:MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = center
        appDelegate.mapView.addAnnotation(myPin)
        //サークル表示用設定
        let circle:MKCircle = MKCircle(centerCoordinate:center , radius:circularRegion.radius)
        appDelegate.mapView.addOverlay(circle)
        
    }
    
    //ジオフェンス領域に侵入した際に呼び出される
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print("test3")
        //appDelegate.viewController.labelField.text = "enter"
        NSLog("enter")
        
    }
    
    //ジオフェンス領域から出た際に呼び出される
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print("test4")
        //appDelegate.viewController.labelField.text = "leave"
        NSLog("leave")
        
    }
    
    //ジオフェンスの情報が取得出来ない際に呼び出される
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("test5")
    }
    
    //地図に各種情報を描画する際に呼び出される(addOverlayを呼ぶと自動的に呼ばれる)
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        print("test6")
        
        //サークルを地図上に描画
        let render:MKCircleRenderer = MKCircleRenderer(overlay: overlay)
        render.strokeColor = UIColor.redColor()
        render.fillColor = UIColor.redColor().colorWithAlphaComponent(0.4)
        render.lineWidth=1
        return render
    }


}

