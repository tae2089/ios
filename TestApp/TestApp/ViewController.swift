import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    //인스턴스 변수 생성
    @IBOutlet var lBelHello: UILabel!
    @IBOutlet var lBelIos: UILabel!
    @IBOutlet var NameText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SendBtn(_ sender: UIButton){
        var s:String  = ""
        if  let a = NameText.text{
            s = a
        }
        lBelHello.text =  "ssss"+s
        
    }
}
