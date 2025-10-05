import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    var alinanSifre = ""
    
    @IBOutlet weak var birinciLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("appeared!")
        textfield.text = ""
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("disappeared!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("will disappear!")
    }

    @IBAction func kontrolettiklandi(_ sender: Any) {
        alinanSifre = textfield.text ?? ""
        
        if alinanSifre == "emir" {
            // Doğru şifre → ikinci sayfaya git
            performSegue(withIdentifier: "toIkinciVC", sender: nil)
        } else {
            // Yanlış şifre → label’da uyarı göster
            birinciLabel.text = "Şifre yanlış"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIkinciVC" {
            let destinationVC = segue.destination as! kinciViewController
            destinationVC.gelenSifre = alinanSifre
        }
    }
}
