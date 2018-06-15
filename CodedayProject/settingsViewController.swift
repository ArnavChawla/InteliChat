import UIKit

var french = false
var spanish = false
var arabic = false
var olive = false
class settingsViewController: UIViewController {

    @IBAction func Arabic(_ sender: Any) {
        arabic = !arabic
    }
    @IBAction func Italy(_ sender: Any) {
        olive = !olive
    }
    @IBAction func Bacl(_ sender: Any) {
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
    }

    @IBOutlet weak var bro: UISwitch!
    @IBOutlet weak var italy: UISwitch!
    @IBOutlet weak var SpanishSwitch: UISwitch!
    @IBAction func SpanishChanged(_ sender: Any) {
        spanish = !spanish
    }
    @IBOutlet weak var French: UISwitch!

    @IBAction func yofrench(_ sender: Any) {
        french = !french
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if arabic == false
        {
            bro.isOn = false
        }
        if olive == false
        {
         italy.isOn = false
        }
        if spanish == false
        {
        SpanishSwitch.isOn = false
        }
        if french == false
        {
        French.isOn = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
