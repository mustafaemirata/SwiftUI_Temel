//
//  ViewController.swift
//  UyariMesajlari
//
//  Created by Mustafa Emir Ata on 4.10.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sifreTekrar: UITextField!
    @IBOutlet weak var sifreField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func kayitOlTiklandi(_ sender: Any) {
        
        // Email boş mu?
        if emailField.text?.isEmpty ?? true {
            
            showAlert(title: "Hata Mesajı",
                      message: "Email boş bırakılamaz. Lütfen tekrar deneyiniz.")
            
        }
        // Şifreler aynı mı?
        else if sifreField.text != sifreTekrar.text {
            
            showAlert(title: "Hata Mesajı",
                      message: "Parolalar eşleşmiyor. Lütfen tekrar deneyiniz.")
            
        }
        // Hepsi doğruysa
        else {
            
            showAlert(title: "Onay Mesajı",
                      message: "Her şey başarılı!")
        }
    }
    
    // Tekrarlayan kodu azaltmak için fonksiyon
    func showAlert(title: String, message: String) {
        let uyariMesaji = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButon = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK buton tıklandı!")
        }
        uyariMesaji.addAction(okButon)
        self.present(uyariMesaji, animated: true, completion: nil)
    }
}
