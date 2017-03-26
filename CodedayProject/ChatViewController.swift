//
//  ChatViewController.swift
//  Potential2017CodedayProject
//
//  Created by Arnav Chawla on 1/28/17.
//  Copyright © 2017 Arnav Chawla. All rights reserved.
//
// it prevents cyberbullying by checking the messages before it is sent
// this will apeal to parents who are buying the kids, their first phone
// it doesn't limit their freedom, but ensures that kids make the right decisions

import UIKit
import FirebaseAuth
import GoogleSignIn
import MobileCoreServices
import AVKit
import JSQMessagesViewController
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import PopupDialog
import FirebaseMessaging
import LanguageTranslatorV2
import FirebaseCore
import FirebaseInstanceID
import SDWebImage
var CurrentChatUserId = String()
var otherDude = String()
var badword = false
var f = 0
var u = false
var newthing = "\(CurrentChatUserId) & \(otherDude)"
var last = "\(otherDude) & \(CurrentChatUserId)"


class ChatViewController: JSQMessagesViewController {
    

    let c = true
    var messages = [JSQMessage]()
    var messageRef = FIRDatabase.database().reference().child("messages")
    @IBOutlet weak var item: UIBarButtonItem!
    var Ref = FIRDatabase.database().reference()
    @IBAction func translation(_ sender: Any) {
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
        let naviVC = storyboard.instantiateViewController(withIdentifier: "settings")as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = naviVC
    }
    var avatarDict =  [String: JSQMessagesAvatarImage]()
    func connectToFcm() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return;
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }


    override func viewDidLoad() {
        
    
        

        JSQMessagesCollectionViewCell.registerMenuAction(#selector(report(_sender:)))
//        UIMenuController.shared.menuItems = [UIMenuItem.init(title: "spam", action: Selector("spam:"))]
        UIMenuController.shared.menuItems = [UIMenuItem.init(title: "report", action : #selector(report(_sender:)))]
        connectToFcm()
        newthing = "\(CurrentChatUserId) & \(otherDude)"
        last = "\(otherDude) & \(CurrentChatUserId)"
        //        messageRef.childByAutoId().setValue("first")
        //        messageRef.childByAutoId().setValue("second")
        //        messageRef.observe(FIRDataEventType.value ){ (snapshot: FIRDataSnapshot) in
        //
        //            if let dict = snapshot.value as? NSDictionary
        //            {
        //                //print(dict)
        //            }
        //        }
        item.width = 100
        super.viewDidLoad()
        if spanish == true
        {
            item.title = "English to Spanish  "
        }
        else if olive == true
        {
            item.title = "English to Italtian   "
        }
        else if arabic == true
        {
            item.title = "English to Arabic   "
        }
        else if french == true
        {
            item.title = "English to French   "
        }
        else
        {
            item.title = "English          "
        }
        
        let currentUser = FIRAuth.auth()?.currentUser
        senderId = FIRAuth.auth()!.currentUser!.uid
        senderDisplayName = FIRAuth.auth()!.currentUser!.displayName
        badword = false
        obsereveMessage()
    }

    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        super.collectionView(collectionView, shouldShowMenuForItemAt: indexPath)
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(report(_sender:))

    }
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        if  action == #selector(report(_sender:)){
//           // self.delete(indexPath.item)
//            self.delete(indexPath.row)
            print("PLLLLSSS")
            print(indexPath.row)
            //collectionView.delete(JSQMessagesCollectionViewCell.self)
            //self.collectionView.reloadData()
         
            Ref.child("posts").child(newthing).observe(.value, with: { (snapsho) in
//                let x = snapsho.value
//                if x == JSQMessagesCollectionViewCell.tex
            })
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(report(_sender:)) {
            return true
        }
        return super.canPerformAction(action, withSender:sender)
    }
    func report(_sender: UIMenuItem) {
        print("Button Pressed")
        Ref.child("posts").child(newthing).observe(.value, with: { (snapshot) in
            
        })
    }
    func obsereveUsers(id: String)
    {
        FIRDatabase.database().reference().child("Users").child(id).observe(.value, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let avatarUrl = dict["url"] as! String
                
                ////print(avatarUrl)
                self.setupAvatar(url: avatarUrl, id: id)
            }
        })
    }
    func setupAvatar(url: String, id: String)
    {
        let fileUrl = NSURL(string: url)
        print("it is\(fileUrl)")
        
        let data = NSData(contentsOf: fileUrl as! URL)
        let image = UIImage(data: data as! Data)
        let usrImg = JSQMessagesAvatarImageFactory.avatarImage(with: image, diameter: 30)
        avatarDict[id] = usrImg
        print("jkjhcbjljmnbvbnjkl;jnbvcnmjkl;jbnv b")
        collectionView.reloadData()
    }
    public func obsereveMessage()
    {
        
        
        
        Ref.child("posts").child(newthing).queryOrderedByKey().observe(.childAdded, with: {snapshot in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let mediaType = dict["MediaType"] as! String
                let senderId = dict["senderId"] as! String
                let senderName = dict["senderName"] as! String
                self.obsereveUsers(id: senderId)
                
                if mediaType == "TEXT"
                {
                    let text = dict["text"] as! String
                    if spanish == false && french == false && arabic == false && olive == false
                    {
                        
                        self.messages.append(JSQMessage(senderId: senderId, displayName: senderName , text: text))
                        
                        self.collectionView.reloadData()
                        
                    }
                    let username = "cb6fa619-4208-431b-8d30-e55a9c1e4b55"
                    
                    let password = "N4ToMv11PVCT                                    "
                    let languageTranslator = LanguageTranslator(username: username, password: password)
                    
                    let failure = { (error: Error) in print(error) }
                    
                    if spanish == true
                    {
                        languageTranslator.translate(text, from: "en", to: "es", failure: failure) {
                            
                            translation in
                            //let translation: String = value.objectForKey("id") as! String
                            
                            print("it is \(translation.translations[0].translation)")
                            //for (translations, value) in translation {
                            //  println("\(key) -> \(value)")
                            //}
                            //         var translation = translation.components(separtedBy: )
                            
                            self.messages.append(JSQMessage(senderId: senderId, displayName: senderName , text: translation.translations[0].translation))
                            
                            self.collectionView.reloadData()
                            
                            
                        }
                    }
                    else if french == true
                    {
                        languageTranslator.translate(text, from: "en", to: "fr", failure: failure) {
                            
                            translation in
                            //let translation: String = value.objectForKey("id") as! String
                            
                            print("it is \(translation.translations[0].translation)")
                            //for (translations, value) in translation {
                            //  println("\(key) -> \(value)")
                            //}
                            //         var translation = translation.components(separtedBy: )
                            
                            self.messages.append(JSQMessage(senderId: senderId, displayName: senderName , text: translation.translations[0].translation))
                            self.collectionView.reloadData()
                            
                            
                        }
                        
                    }
                    else if olive == true
                    {
                        languageTranslator.translate(text, from: "en", to: "it", failure: failure) {
                            
                            translation in
                            //let translation: String = value.objectForKey("id") as! String
                            
                            print("it is \(translation.translations[0].translation)")
                            //for (translations, value) in translation {
                            //  println("\(key) -> \(value)")
                            //}
                            //         var translation = translation.components(separtedBy: )
                            
                            self.messages.append(JSQMessage(senderId: senderId, displayName: senderName , text: translation.translations[0].translation))
                            self.collectionView.reloadData()
                            
                            
                        }
                        
                    }
                    else if arabic == true
                    {
                        languageTranslator.translate(text, from: "en", to: "ar", failure: failure) {
                            
                            translation in
                            //let translation: String = value.objectForKey("id") as! String
                            
                            print("it is \(translation.translations[0].translation)")
                            //for (translations, value) in translation {
                            //  println("\(key) -> \(value)")
                            //}
                            //         var translation = translation.components(separtedBy: )
                            
                            self.messages.append(JSQMessage(senderId: senderId, displayName: senderName , text: translation.translations[0].translation))
                            self.collectionView.reloadData()
                            
                            self.collectionView.reloadData()
                            
                            
                            
                        }
                        
                    }
                    
                }
                else if mediaType == "Photo"
                {
                    let fileURL =  dict["fileURL"] as! String
                    let url = NSURL(string: fileURL)
                    let data = NSData(contentsOf: url as! URL)
                    let picture = UIImage(data: data! as Data)
                    let photo = JSQPhotoMediaItem(image: picture)
                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: photo))
                    //print("phojlkflkjslkajld")
                    let downloader = SDWebImageDownloader.shared()
                    downloader.downloadImage(with: URL(string: fileURL)!, options: [], progress: nil, completed: { (image, data, error, finished) in
                        DispatchQueue.main.async(execute: {
                            photo?.image = image
                            self.collectionView.reloadData()
                        })
                    })

                    if self.senderId == senderId
                    {
                        photo!.appliesMediaViewMaskAsOutgoing = true
                    }
                    else
                    {
                        photo!.appliesMediaViewMaskAsOutgoing = false
                    }
                    
                }
                else if mediaType == "VIDEO"
                {
                    let fileURL =  dict["fileURL"] as! String
                    let video = NSURL(string: fileURL)
                    let VideoItem = JSQVideoMediaItem(fileURL: video as URL!, isReadyToPlay: true)
                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: VideoItem))
                    if self.senderId == senderId
                    {
                        VideoItem!.appliesMediaViewMaskAsOutgoing = true
                    }
                    else
                    {
                        VideoItem!.appliesMediaViewMaskAsOutgoing = false
                    }
                    
                    
                }
                
                
                self.collectionView.reloadData()
            }
            
            
        })
        
    }
     override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        badword = false
        u = false
        let banned  = ["gay", "g*y", "retarded", "retard", "r*tard", "ret*rd", "joke", "adopted", "nigga", "nigger", "spastic", "midget", "dwarf", "autistic", "bipolar", "depressed", "ocd", "nazi", "republican", "democrat", "Trump", "Obama", "uptight", "stupid", "stup*d", "st*pid", "stupidest", "stupider", "angry", "annoy", "annoying", "annoyed", "awful", "awf*l", "awfully", "awfullest", "alarming", "ashamed", "ashaming", "bad", "badly", "boring", "bored", "bitch", "b*tch", "bitchy", "callous", "can’t", "crazy", "cutting", "cutter", "cut", "coon", "crybaby", "cry", "cruel", "creepy", "creep", "corrosive", "cold-hearted", "cold", "cunt", "clumsy", "complaining", "dead", "depressed", "disappointment", "despicable", "die", "dirty", "dumb", "dumber", "dumbest", "disgusting", "dreadful", "dreary", "evil", "failure", "failing", "fail", "faulty", "fag", "f*g", "feeble", "filthy", "fucking", "fucked", "foul", "fool", "fuck", "f*ck", "f**k", "f***", "ghastly", "grim", "gross", "grotesque", "gruesome", "haggard", "harmful", "hate", "hideous", "hoe", "h*e", "horrendous", "horrible", "hurt", "icky", "ignore", "inferior", "immature", "imperfect", "impossible", "incompetent", "insane", "junk", "loser", "l*ser", "lazy", "malicious", "mean", "mess", "monstrous", "mistake", "naive", "nazi", "nasty", "naughty", "never", "nobody", "nonsense", "odious", "offensive", "pain", "pessimistic", "porn", "pr0n", "p0rn", "p*rn", "p**n", "petty", "poisonous", "poor", "questionable", "quirky", "quit", "reject", "repulsive", "revolting", "rotten", "rude", "ruthless", "ridiculous", "sad", "scary", "suck", "s*ck", "slut", "sl*t", "sickening", "stupid", "st*pid", "stup*d", "st*p*d", "s****d", "smell", "stink", "substandard", "sex", "xxx", "suicide", "kill", "terrible", "threatening", "ugly", "unfavorable", "unhappy", "unpleasant", "upset", "unsightly", "unwanted", "unwelcome", "vile", "weak", "wicked", "whore", "wh*re", "wh0re","wrong", "weird", "worthless", "yucky", "zero","penis"]
        
        
        let phrases = ["never mind, you wouldn't get it", "makes me want to kill myself", "like a girl", "take a chill pill", "i don’t care", "you’re just confused", "have you been living under a rock", "you’re in the way", "no one cares if you die", "waste of oxygen", "no one likes you", "you asked for it", "grow up", "kill yourself",  "just putting up with you", "be better"]
        
        
        
        let you=["you", "you’re","your","ur", "u","penis"]
        

        let newMessage = Ref.child("posts").child(newthing).childByAutoId()
        let otherNewMessage = Ref.child("posts").child(last).childByAutoId()
        let messageData: [String : String] = ["text": text, "senderId": senderId, "senderName":  senderDisplayName, "MediaType": "TEXT"]
        var analyzedMessage = messageData["text"]!.components(separatedBy: .whitespacesAndNewlines)
        
        var i = analyzedMessage.count
        i = i - 1
        var x = banned.count
        x = x - 1
        var youAre = false
        
        
        while i >= 0
        {
            
            var messageSnippet = analyzedMessage[i].lowercased()
            x = banned.count - 1
            
            let username = "a6b23ef3-db7d-43cd-a1c2-400ed9e78e5d"
            
            let password = "7cFuiixOmQtr"
            let languageTranslator = LanguageTranslator(username: username, password: password)
            
            let failure = { (error: Error) in print(error) }
            languageTranslator.translate(text, from: "en", to: "es", failure: failure) {
                
                translation in
                //let translation: String = value.objectForKey("id") as! String
                
                print("it is \(translation.translations[0].translation)")
                //for (translations, value) in translation {
                //  println("\(key) -> \(value)")
                //}
                //                                        var translation = translation.components(separtedBy: )
                
                
                
                
            }
            
            
            while x >= 0
            {
                if messageSnippet.contains(banned[x]) {
                    badword = true
                }
                
                x = x-1
            }
            
            if messageSnippet == you[0] || messageSnippet == you[1] || messageSnippet == you[2] || messageSnippet == you[3] || messageSnippet == you[4]
            {
                youAre = true
                print("\(badword) + \(youAre)")
            }
            
            print("\(messageSnippet) \(badword) \(youAre)")
            i = i-1
            if messageSnippet == "schoolcool"
            {
                messages.append(JSQMessage(senderId: "AS", displayName: "as" , text: "schoolcool"))
            }
        }
        
        if (badword && youAre)
        {
            let title = "This is inapproprite"
            let message = "Please think before you type"
            
            let popup = PopupDialog(title: title, message: message
            )
            let buttonOne = CancelButton(title: "Sorry") {
                print("You canceled the dialog.")
                
            }
            
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            
            self.finishSendingMessage()
        }
        else
        {
            newMessage.setValue(messageData)
            otherNewMessage.setValue(messageData)
            self.finishSendingMessage(animated: true)
        }
        
    }
    
    func sendMedia(picture: UIImage?, video: NSURL?){
        if let picture = picture
        {
            let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\(NSDate.timeIntervalSinceReferenceDate)"
            
            //print(filePath)
            let data = UIImageJPEGRepresentation(picture, 1)
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpg"
            FIRStorage.storage().reference().child(filePath).put(data!, metadata: metaData) { (metadata, error) in
                if error != nil
                {
                    //print(error?.localizedDescription)
                    return
                }
                let fileURL = metadata?.downloadURLs![0].absoluteString
                let newMessage = self.Ref.child("posts").child(newthing).childByAutoId()
                let otherNewMessage = self.Ref.child("posts").child(last).childByAutoId()
                let messageData = ["fileURL": fileURL, "senderId": self.senderId, "senderName":  self.senderDisplayName, "MediaType": "Photo"]
                newMessage.setValue(messageData)
                otherNewMessage.setValue(messageData)
            }
        }
        else if let video = video
        {
            let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\(NSDate.timeIntervalSinceReferenceDate)"
            //print(filePath)
            let data = NSData(contentsOf: video as URL)
            let metaData = FIRStorageMetadata()
            metaData.contentType = "video/mp4"
            FIRStorage.storage().reference().child(filePath).put(data! as Data, metadata: metaData) { (metadata, error) in
                if error != nil
                {
                    //print(error?.localizedDescription)
                    return
                }
                let fileURL = metadata?.downloadURLs![0].absoluteString
                let newMessage = self.Ref.child("posts").child(newthing).childByAutoId()
                let otherNewMessage = self.Ref.child("posts").child(last).childByAutoId()
                
                let messageData = ["fileURL": fileURL, "senderId": self.senderId, "senderName":  self.senderDisplayName, "MediaType": "VIDEO"]
                newMessage.setValue(messageData)
                otherNewMessage.setValue(messageData)
            }
            
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == self.senderId
        {
            let bubbleFactory = JSQMessagesBubbleImageFactory()
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .jsq_messageBubbleGreen())
            
        }
        else{
            
            let bubbleFactory = JSQMessagesBubbleImageFactory()
            return bubbleFactory?.incomingMessagesBubbleImage(with: .gray)
            
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let mesage = messages[indexPath.item]
        return avatarDict[mesage.senderId]
        //        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "profileImage" ) , diameter: 30)
    }
    override func didPressAccessoryButton(_ sender: UIButton!) {
        //print("attach")
        let sheet = UIAlertController(title: "Media Messages", message: "Please select a media", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction) in
            
        }
        let photo = UIAlertAction(title: "Attach a Picture", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            self.getMediaFrom(type: kUTTypeImage)
            
        }
        let video = UIAlertAction(title: "Attach a Video", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
            self.getMediaFrom(type: kUTTypeMovie )
        }
        sheet.addAction(photo)
        sheet.addAction(video)
        sheet.addAction(cancel)
        self.present(sheet, animated: true, completion: nil)
        //        let imagePicker = UIImagePickerController()
        //        imagePicker.delegate = self
        //        self.present(imagePicker, animated: true, completion: nil)
    }
    func getMediaFrom(type: CFString){
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
        
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        ////print("tapped at: \(indexPath.item)")
        let message  = messages[indexPath.item]
        if message.isMediaMessage == true
        {
            if let url = message.media as? JSQVideoMediaItem
            {
                let player = AVPlayer(url: url.fileURL)
                let playerView = AVPlayerViewController()
                playerView.player = player
                self.present(playerView, animated: true, completion: nil)
                
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(messages.count)
        return messages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    @IBAction func undo(_ sender: Any) {
        self.finishSendingMessage(animated: true)
        self.collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
            self.messages.removeLast()
            
            self.collectionView.reloadData()
        })
        
        
    }
    
    func move()
    {
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
        let naviVC = storyboard.instantiateViewController(withIdentifier: "yo")as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout(_ sender: Any) {
        move()
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
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //print("photo done")
        
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            //            let photo = JSQPhotoMediaItem(image: picture)
            //            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photo))
            sendMedia(picture: picture, video: nil)
        }
        else if let video = info[UIImagePickerControllerMediaURL] as? NSURL
        {
            //            let VideoItem = JSQVideoMediaItem(fileURL: video as URL!, isReadyToPlay: true)
            //            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: VideoItem))
            sendMedia(picture: nil, video: video)
        }
        
        collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
}


