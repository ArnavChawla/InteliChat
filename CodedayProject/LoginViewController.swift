import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase
import TwitterKit
import FBSDKLoginKit
import Fabric
import Google
var x = false
var name = ""
var e = false
var ne = false
var theone = ""
var anath = ""
var pls = false
var isNew = false
var EmailString = ""
var PASSWORD = ""
struct usersa {
    let username : String!
    
    let uid : String!
    let url : String!
}
class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate{
     var  users = [usersa]()
      @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    var dict : [String : AnyObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().clientID = "951724250924-7slvrgt4t5ta1kt14dan9t2kkj6h6btt.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        try! GIDSignIn.sharedInstance().signOut()
        x = false
        e = false
        ne = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CreateAccount(_ sender: Any) {
    
        if (Email.text?.contains("@"))!
        {
            EmailString = Email.text!
            PASSWORD = Password.text!
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            if s == true
            {
                storyboard = UIStoryboard(name: "Main", bundle: nil)
            }
            else if p == true
            {
                storyboard = UIStoryboard(name: "big", bundle: nil)
            }
            else if se == true
            {
                storyboard = UIStoryboard(name: "se", bundle: nil)
            }
            else if os == true
            {
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
            let naviVC = storyboard.instantiateViewController(withIdentifier: "eula")as! UIViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = naviVC
        }
        else
        {
            print("hi")
        }
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
        let naviVC = storyboard.instantiateViewController(withIdentifier: "yo")as! UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
    func movespecial()
    {
        let database = FIRDatabase.database().reference()
        database.child("Users").observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
            print(snapshot)
//            if let value = snapshot.value as? [String: AnyObject] {
//                let ui = value["id"] as! String
            if snapshot.hasChild( FIRAuth.auth()!.currentUser!.uid)
                {
                    var storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if s == true
                    {
                        storyboard = UIStoryboard(name: "Main", bundle: nil)
                    }
                    else if p == true
                    {
                        storyboard = UIStoryboard(name: "big", bundle: nil)
                    }
                    else if se == true
                    {
                        storyboard = UIStoryboard(name: "se", bundle: nil)
                    }
                    else if os == true
                    {
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
                    let naviVC = storyboard.instantiateViewController(withIdentifier: "eula")as! UIViewController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = naviVC
                }
            //}
            
            
        })
    

    }
    @IBAction func LoginPressed(_ sender: Any) {

            login()
            e = true
            name = theone
        
        

    }
    func login()
    {

        FIRAuth.auth()?.signIn(withEmail: Email.text!, password: Password.text!, completion: { (user, error) in
            if error != nil{
                print(error?.localizedDescription)
            }
            else
            {
                print(user?.uid)
                                self.move()
            }
        })
        
    }


    @IBAction func GoogleLoginDidTapped(_ sender: Any) {
        print("Google login completed")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()

    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil
        {
            auth(authentication: user.authentication)
        }
        else
        {
            print(error.localizedDescription)
        }
        
    }
    func auth(authentication: GIDAuthentication)
    {
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken , accessToken: authentication.accessToken)
        
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil{
                print(error?.localizedDescription)
            }
            else
            {
                
            
                print(user?.email)

                print(user?.displayName)
 
                x = true
                name = (user?.displayName)!
                self.movespecial()
            }
            
        })
    }


//    @IBAction func Face(_ sender: Any) {
//
//    }
//    @IBAction func plss(_ sender: Any) {
//        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
//            if (error == nil){
//                let fbloginresult : FBSDKLoginManagerLoginResult = result!
//                
//                if fbloginresult.grantedPermissions != nil {
//                    if(fbloginresult.grantedPermissions.contains("email"))
//                    {
//                        self.getFBUserData()
//                        fbLoginManager.logOut()
//                    }
//                }
//            }
//            else
//            {
//                self.move()
//            }
//        }
//    }
//    func getFBUserData(){
//        if((FBSDKAccessToken.current()) != nil){
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
//                if (error == nil){
//                    self.dict = result as! [String : AnyObject]
//                    print(result!)
//                    print(self.dict)
//                    self.move()
//                }
//            })
//        }
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // this is the code that i want to work
//    let database = FIRDatabase.database().reference()
//    database.child("Users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//    print(snapshot)
//    if let value = snapshot.value as? [String: AnyObject] {
//    let ui = value["id"] as! String
//    if ui != FIRAuth.auth()!.currentUser!.uid
//    {
//    isNew = true
//    print("is new is \(isNew)")
//    pls = true
//    self.move1()
//    
//    
//    }
//    
//    }
//    else
//    {
//    self.move()
//    }
//    
//    })

}
