//
//  SignInViewController.swift
//  Carousel
//
//  Created by Anh Tuan on 9/15/14.
//  Copyright (c) 2014 wafrat. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    @IBOutlet weak var imageComponent: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        // Delay for 2 seconds, then run the code between the braces.
        delay(2) {
            self.checkPassword()
        }
    }
    
    func checkPassword() {
        if (emailText.text == "") {
            var alertView = UIAlertView(title: "Email Required", message: "Please enter your email address", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else if (emailText.text != "atn832@gmail.com" || passwordText.text != "112233") {
            var alertView = UIAlertView(title: "Sign In Failed", message: "Incorrect email or password", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else {
            performSegueWithIdentifier("welcomeSegue", sender: self)
        }
    }
    
    @IBOutlet weak var onLogin: UIButton!
    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    @IBAction func onSignInBackClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        // top: -85px
        // bottom: -keyboard height
        
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
                self.topView.frame.origin.y -= 85
                self.bottomView.frame.origin.y -= kbSize.height
                self.imageComponent.alpha = 0
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
                self.topView.frame.origin.y += 85
                self.bottomView.frame.origin.y += kbSize.height
                self.imageComponent.alpha = 1
            }, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
