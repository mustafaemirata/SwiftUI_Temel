import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var kahramanImageView: UIImageView!
    @IBOutlet weak var kahramanLabel: UILabel! // ✅ Burayı UIImageView yerine UILabel yaptık
    
    var secilenKahramanIsim: String?
    var secilenKahramanGorsel: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Güvenli kullanım
        kahramanLabel.text = secilenKahramanIsim ?? "Bilinmeyen Kahraman"
        if let imageName = secilenKahramanGorsel {
            kahramanImageView.image = UIImage(named: imageName)
        }
    }
}
