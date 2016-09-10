//
//  ConnectTokyoTech.swift
//  myApp
//
//  Created by *** **** on 2016/09/10.
//  Copyright © 2016年 *** *****. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork


class ConnectTokyoTech: NSObject,UIWebViewDelegate {
    var webView:UIWebView!
    var defaults:NSUserDefaults!
    override init(){
        super.init()
        
        webView = UIWebView()
        webView.delegate = self
        defaults = NSUserDefaults.standardUserDefaults()
    }

    private func getRetrievedWifiNetwork() -> String {
        guard let interfaces:CFArray! = CNCopySupportedInterfaces()else{
            return "error"
        }
        for i in 0..<CFArrayGetCount(interfaces){
            guard let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)else{
                continue;
            }
            let rec = unsafeBitCast(interfaceName, AnyObject.self)
            guard let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)") else {
                continue
            }
            guard let interfaceData = unsafeInterfaceData as Dictionary! else {
                continue
            }
            return interfaceData["SSID"] as! String
        }
        return "error"
    }
    func connectTokyoTech(){
        if getRetrievedWifiNetwork() == "TokyoTech"{
            let url = NSURL(string: "https://wlanauth.noc.titech.ac.jp")
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            
        }
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        print("loaded")
        let studentNumber = defaults.objectForKey("std_num") as? String
        let password = defaults.objectForKey("pass") as? String
        if let currentURL = webView.request?.URL?.absoluteString{
            print(currentURL)
            if currentURL == "https://wlanauth.noc.titech.ac.jp/"{
                let script = String(format: "(function(){ var username = document.getElementsByName('username')[0]; username.value = '%@'; var password = document.getElementsByName('password')[0]; password.value = '%@'; var submit = document.getElementsByName('Submit')[0]; submit.click(); })();", arguments:[studentNumber!,password!])
                webView.stringByEvaluatingJavaScriptFromString(script)
            }
            if currentURL == "https://wlanauth.noc.titech.ac.jp/login.html"{
                webView.stringByEvaluatingJavaScriptFromString("location.href='https://www.google.co.jp'");
            }
        }
    }
    
}