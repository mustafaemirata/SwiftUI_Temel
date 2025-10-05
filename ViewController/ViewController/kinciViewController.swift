import UIKit

class kinciViewController: UIViewController {

    @IBOutlet weak var bukunansifre: UILabel!
    @IBOutlet weak var ikinciLabel: UILabel!
    
    var gelenSifre: String?   // Burada şifreyi tutacağız
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let sifre = gelenSifre {
            bukunansifre.text = "Alınan şifre: \(sifre)"
        }
    }
}
