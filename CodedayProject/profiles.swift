import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import GoogleSignIn
struct user {
    let username : String!
    let uid : String!
    let url : String!
}
var t = false
class profileVc: UITableViewController
{
    var  users = [user]()
    
    override func viewDidLoad() {
        let database = FIRDatabase.database().reference()
        database.child("Users").queryOrderedByKey().observe(.childChanged, with: { (snapshot) in
            print(snapshot)
            if let value = snapshot.value as? [String: AnyObject] {
                let ui = value["id"] as! String
                let uia = value["blocked by"] as! String

                if ui != FIRAuth.auth()!.currentUser!.uid
                {
                    if uia != FIRAuth.auth()!.currentUser!.uid
                    {
                    let username = value["dislayName"] as! String
                    let uid = value["id"] as! String
                    let profileImageURL = value["url"] as! String
                    self.users.append(user(username: username ,uid: uid, url: profileImageURL))
                    }
                }
                
                self.tableView.reloadData()
                print(self.users)
            }
            
            
        })
        database.child("Users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            if let value = snapshot.value as? [String: AnyObject] {
                let ui = value["id"] as! String
                let uia = value["blocked by"] as! String
                
                if ui != FIRAuth.auth()!.currentUser!.uid
                {
                    if uia != FIRAuth.auth()!.currentUser!.uid
                    {
                        let username = value["dislayName"] as! String
                        let uid = value["id"] as! String
                        let profileImageURL = value["url"] as! String
                        self.users.append(user(username: username ,uid: uid, url: profileImageURL))
                    }
                }
                
                self.tableView.reloadData()
                print(self.users)
            }
            
            
        })

        
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Block", handler: { (action, indexPath) in
            print("Edit tapped")
            CurrentChatUserId = self.users[indexPath.row].uid
            let database = FIRDatabase.database().reference()
            database.child("Users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
                print(snapshot)
                if let value = snapshot.value as? [String: AnyObject] {
                    let user = FIRAuth.auth()!.currentUser
                    let newUser = FIRDatabase.database().reference().child("Users").child(self.users[indexPath.row].uid!)
                    newUser.setValue(["dislayName": "\(self.users[indexPath.row].username!)", "id": "\(self.users[indexPath.row].uid!)", "url": "\(self.users[indexPath.row].url!)", "Agreed": "true", "blocked by" : "\(user!.uid)"])
                let uia = value["blocked by"] as! String
                    
                }
                
                
            })

        })
        editAction.backgroundColor = UIColor.red
        return [editAction]
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
        
        let naviVC = storyboard.instantiateViewController(withIdentifier: "Login")as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }

    @IBAction func DidTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "settings")as! UINavigationController 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
    @IBAction func LogOutTapped(_ sender: Any) {
        try!  GIDSignIn.sharedInstance().signOut()
        try! FIRAuth.auth()?.signOut()
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
        let naviVC = storyboard.instantiateViewController(withIdentifier: "hello")as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if self.users[indexPath.row].uid != FIRAuth.auth()?.currentUser?.uid
        {
            let imageView = cell?.viewWithTag(1) as! UIImageView
            imageView.alpha = 0
            
            let nameLbl = cell?.viewWithTag(2) as! UILabel
            nameLbl.alpha = 0
            nameLbl.text = users[indexPath.row].username
            let fileURL =  self.users[indexPath.row].url as String
            let url = NSURL(string: fileURL)
            let data = NSData(contentsOf: url as! URL)
            let picture = UIImage(data: data! as Data)
            imageView.image = picture
            nameLbl.text = self.users[indexPath.row].username
            
            DispatchQueue.main.async(execute: {
                UIView.animate(withDuration: 0.5, animations: {
                    if nameLbl.text != "Label"
                    {
                    nameLbl.alpha = 1
                    imageView.alpha = 1
                    }
                    
                })
            })
        }
          return cell!
        
      
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        let naviVC = storyboard.instantiateViewController(withIdentifier: "VC")as! UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
        CurrentChatUserId = users[indexPath.row].uid
        print(users[indexPath.row].uid)
        otherDude = (FIRAuth.auth()!.currentUser!.uid)
        
        
    }
    
    
    
}

