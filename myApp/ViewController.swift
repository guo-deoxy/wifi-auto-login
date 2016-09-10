//
//  ViewController.swift
//  myApp
//
//  Created by *** **** on 2016/09/04.
//  Copyright © 2016年 *** ****. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    

    @IBOutlet weak var mapView: MKMapView!



    
    
    let userDefaults = NSUserDefaults.standardUserDefaults();
    var locationManager:LocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.viewController = self
        appDelegate.mapView = mapView
        locationManager = LocationManager()
        locationManager.startLocationManager()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

