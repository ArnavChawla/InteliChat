//
//  SetupView.swift
//  MessagingApp
//
//  Created by Jared Davidson on 7/15/16.
//  Copyright © 2016 Archetapp. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

var name1 = ""
var ui = ""
class setupView : UIViewController {
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var nameTextField: UITextField!
    
    var profileImage = UIImage()
    
    var captureSession = AVCaptureSession()
    var stillImageOutput = AVCaptureStillImageOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    
    override func viewDidLoad() {
        
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        for device in devices! {
            
            if (device as AnyObject).position == AVCaptureDevicePosition.front {
                
                
                do {
                    
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input) {
                        captureSession.addInput(input)
                        stillImageOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                        
                        if captureSession.canAddOutput(stillImageOutput) {
                            captureSession.addOutput(stillImageOutput)
                            captureSession.startRunning()
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                            cameraView.layer.addSublayer(previewLayer)
                            
                            previewLayer.bounds = cameraView.frame
                            previewLayer.position = CGPoint(x: cameraView.frame.width / 2, y: cameraView.frame.height / 2)
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                catch {
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: {
                buffer, error in
                
                let imageData  = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                
                self.profileImage = UIImage(data: imageData!)!
            })
            
            
            
        }
        
    }
    
    @IBAction func Submit(_ sender: AnyObject) {
        
        if profileImage != nil && nameTextField.text != nil {
            
            let storageRef = FIRStorage.storage().reference()
            let databaseRef = FIRDatabase.database().reference()
            
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            let profileImageData = UIImageJPEGRepresentation(profileImage, 0.4)
            
            let profileImageRef = storageRef.child("ProfileImages/\(uid!)/profileImage.jpg")
            profileImageRef.put(profileImageData!, metadata: nil) {
                metadata, error in
                
                if error != nil{
                    
                    print(error)
                    
                }
                else{
                    
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    print(downloadURL)
                    let username = self.nameTextField.text
                    name1 = username!
                    ui = uid!
                    let newUser = FIRDatabase.database().reference().child("Users").child(uid!)
                    newUser.setValue(["dislayName": "\(username!)", "id": "\(uid!)", "url": "\(downloadURL!)", "Agreed": "true", "blocked by" : "nil"])
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
                    
                    let naviVC = storyboard.instantiateViewController(withIdentifier: "yo")as! UIViewController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = naviVC
                }
                
                
                
            }
        }
        
        
        
    }
    
}



















