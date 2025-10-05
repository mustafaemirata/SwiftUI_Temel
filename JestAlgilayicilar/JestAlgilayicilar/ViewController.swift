import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yazi: UILabel!
    @IBOutlet weak var resim: UIImageView!
    var ankara=false

    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        resim.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselDegistir))
        resim.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gorselDegistir() {
        if ankara==false {
            print("tiklandi...")
            resim.image=UIImage(named:"ankara.jpg")
            yazi.text="Ankara"
            ankara=true
        }else {
            resim.image=UIImage(named:"istanbul.jpg")
            yazi.text="İstanbul"
            ankara=false
        }
        
        
        
        
    }
}
