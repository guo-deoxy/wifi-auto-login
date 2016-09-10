//
//  ConfigViewController.swift
//  myApp
//
//  Created by *** **** on 2016/09/10.
//  Copyright © 2016年 *** ****. All rights reserved.
//

import Foundation
import UIKit

class ConfigViewController:UITableViewController,UITextFieldDelegate{
    var defaults:NSUserDefaults!
    
    @IBOutlet var studentNumberField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBAction func returnMainView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults = NSUserDefaults.standardUserDefaults()
        if let studentNumber = defaults.objectForKey("std_num") as? String{
            studentNumberField.text = studentNumber
        }
        if let password = defaults.objectForKey("pass") as? String{
            passwordField.text = password
        }
        studentNumberField.delegate = self;
        passwordField.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(animated: Bool) {
        defaults.setObject(studentNumberField.text, forKey: "std_num")
        defaults.setObject(passwordField.text, forKey: "pass")

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
