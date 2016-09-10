//
//  File.swift
//  myApp
//
//  Created by *** **** on 2016/09/07.
//  Copyright © 2016年 *** ****. All rights reserved.
//

import Foundation
import MapKit

class LocationManager:NSObject,CLLocationManagerDelegate, UIApplicationDelegate,MKMapViewDelegate {
    var locationManager:CLLocationManager!
    var cordinate:CLLocationCoordinate2D!
    var region:CLRegion!
    
    func startLocationManager(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = Double(MAXFLOAT)
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        //locationManager.startUpdatingHeading()
 
        cordinate = CLLocationCoordinate2DMake(35.605105, 139.683391)
        region = CLCircularRegion(center:cordinate , radius:257.0, identifier:"tokyoTech1")
        locationManager.startMonitoringForRegion(region)
        cordinate=CLLocationCoordinate2DMake(35.607164, 139.681020)
        region = CLCircularRegion(center:cordinate , radius:120.0, identifier:"tokyoTech2")
        locationManager.startMonitoringForRegion(region)
        cordinate=CLLocationCoordinate2DMake(35.601118, 139.684595)
        region = CLCircularRegion(center:cordinate , radius:171, identifier:"tokyoTech3")
        locationManager.startMonitoringForRegion(region)
        cordinate=CLLocationCoordinate2DMake(35.608308, 139.679262)
        region = CLCircularRegion(center:cordinate , radius:75, identifier:"tokyoTech4")
        locationManager.startMonitoringForRegion(region)
        cordinate=CLLocationCoordinate2DMake(35.606780, 139.684321)
        region = CLCircularRegion(center:cordinate , radius:180, identifier:"tokyoTech5")
        locationManager.startMonitoringForRegion(region)
        cordinate=CLLocationCoordinate2DMake(35.603492, 139.683627)
        region = CLCircularRegion(center:cordinate , radius:200, identifier:"tokyoTech6")
        locationManager.startMonitoringForRegion(region)
        locationManager.delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mapView.delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mapView.showsUserLocation=true
        
    }
    func requestLocation(){
        locationManager.requestLocation()
    }
}