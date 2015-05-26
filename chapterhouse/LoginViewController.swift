//
//  LoginViewController.swift
//  chapterhouse
//
//  Created by Stephen Arifin on 5/19/15.
//  Copyright (c) 2015 Chapter House. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func login(sender: UIButton) {
        
        let email = "stephen.arifin@gmail.com"
        let password = "testpassword"
        
        loginActivityIndicator.startAnimating()
        
        loginPost(email, password: password)
        
    }
    
    func loginPost(email: NSString, password: NSString) -> Void {
        
        let loginString = "user[email]=\(email)&user[password]=\(password)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://chapter-house-test.herokuapp.com/users/sign_in")!)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = loginString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in

            if error != nil
            {
                println("error=\(error)")
                return
            }
            
            var cookies:[NSHTTPCookie] = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies as! [NSHTTPCookie]
            
            // You can print out response object
            println("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            println("COOKIES:  \(cookies.count)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
            
            if let parseJSON = myJSON {
                // Now we can access value of First Name by its key
                var firstNameValue = parseJSON["firstName"] as? String
                println("firstNameValue: \(firstNameValue)")
            }
            
            self.loginActivityIndicator.stopAnimating()
            
            // Need to find a better way to do this
            if cookies.count != 0 {
                println("Leaving login screen...")
                self.leaveLoginScreen()
            }
            
            }).resume()
        

    }
    
    func leaveLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("membersList") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
