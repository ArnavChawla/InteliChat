//
//  EulaViewController.swift
//  CodedayProject
//
//  Created by Arnav Chawla on 3/9/17.
//  Copyright © 2017 Arnav Chawla. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class EulaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Disagree(_ sender: Any) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        if s == true
        {
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        else if p == true{
            storyboard = UIStoryboard(name: "big", bundle: nil)
        }
        else if se == true
        {
            storyboard = UIStoryboard(name: "se", bundle: nil)
        }
        else if os == true{
            storyboard = UIStoryboard(name: "4s", bundle: nil)
        }
        else if ip1 == true
        {
            storyboard = UIStoryboard(name: "ipad1", bundle: nil)
        }
        else if ipb == true
        {
            storyboard = UIStoryboard(name: "ipadbig", bundle: nil)
        }
        let naviVC = storyboard.instantiateViewController(withIdentifier: "hello")as! UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC

    }

    @IBAction func agree(_ sender: Any) {
        if x == true
        {
            let user = FIRAuth.auth()!.currentUser
            let newUser = FIRDatabase.database().reference().child("Users").child(user!.uid)
            newUser.setValue(["dislayName": "\(user!.displayName!)", "id": "\(user!.uid)", "url": "\(user!.photoURL!)", "Agreed": "true", "blocked by" : "nil"])

            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            if s == true
            {
                storyboard = UIStoryboard(name: "Main", bundle: nil)
            }
            else if p == true{
                storyboard = UIStoryboard(name: "big", bundle: nil)
            }
            else if se == true
            {
                storyboard = UIStoryboard(name: "se", bundle: nil)
            }
            else if os == true{
                storyboard = UIStoryboard(name: "4s", bundle: nil)
            }
            else if ip1 == true
            {
                storyboard = UIStoryboard(name: "ipad1", bundle: nil)
            }
            else if ipb == true
            {
                storyboard = UIStoryboard(name: "ipadbig", bundle: nil)
            }
            let naviVC = storyboard.instantiateViewController(withIdentifier: "yo")as! UIViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = naviVC
        }
        else
        {
            FIRAuth.auth()?.createUser(withEmail: EmailString, password: PASSWORD, completion: { (user, error) in
                if error != nil{
                    print(error?.localizedDescription)
                }
                else
                {
                    isNew = true
                    print("userLoggedIn")
                    FIRAuth.auth()?.signIn(withEmail: EmailString, password: PASSWORD, completion: { (user, error) in
                        if error != nil{
                            print(error?.localizedDescription)
                        }
                        else
                        {
                            print(user?.uid)
                        }
                    })
                    var storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if s == true
                    {
                        storyboard = UIStoryboard(name: "Main", bundle: nil)
                    }
                    else if p == true{
                        storyboard = UIStoryboard(name: "big", bundle: nil)
                    }
                    else if se == true
                    {
                        storyboard = UIStoryboard(name: "se", bundle: nil)
                    }
                    else if os == true{
                        storyboard = UIStoryboard(name: "4s", bundle: nil)
                    }
                    else if ip1 == true
                    {
                        storyboard = UIStoryboard(name: "ipad1", bundle: nil)
                    }
                    else if ipb == true
                    {
                        storyboard = UIStoryboard(name: "ipadbig", bundle: nil)
                    }
                    let naviVC = storyboard.instantiateViewController(withIdentifier: "eula") as! UIViewController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = naviVC
                    ne = true
                }
                
            })

            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            if s == true
            {
                storyboard = UIStoryboard(name: "Main", bundle: nil)
            }
            else if p == true{
                storyboard = UIStoryboard(name: "big", bundle: nil)
            }
            else if se == true
            {
                storyboard = UIStoryboard(name: "se", bundle: nil)
            }
            else if os == true{
                storyboard = UIStoryboard(name: "4s", bundle: nil)
            }
            else if ip1 == true
            {
                storyboard = UIStoryboard(name: "ipad1", bundle: nil)
            }
            else if ipb == true
            {
                storyboard = UIStoryboard(name: "ipadbig", bundle: nil)
            }
            let naviVC = storyboard.instantiateViewController(withIdentifier: "pls")as! UIViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = naviVC
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
