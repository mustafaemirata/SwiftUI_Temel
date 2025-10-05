//
//  ViewController.swift
//  UserDefaultProjesi
//
//  Created by Mustafa Emir Ata on 4.10.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notText: UITextField!
    @IBOutlet weak var zamanText: UITextField!
    @IBOutlet weak var labelNot: UILabel!
    @IBOutlet weak var zamanLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Kaydedilen verileri çekiyoruz
        let kaydedilenNot = UserDefaults.standard.object(forKey: "not") as? String
        let kaydedilenZaman = UserDefaults.standard.object(forKey: "zaman") as? String
   
        if let gelenNot = kaydedilenNot {
            labelNot.text = "Yapılacak iş: " + gelenNot
        }
        if let gelenZaman = kaydedilenZaman {
            zamanLabel.text = "Zaman: " + gelenZaman
        }
    }

    @IBAction func kaydetTiklandi(_ sender: Any) {
        // Kullanıcının girdiği değerleri kaydediyoruz
        UserDefaults.standard.set(notText.text, forKey: "not")
        UserDefaults.standard.set(zamanText.text, forKey: "zaman")
        
        // Label’larda gösteriyoruz
        labelNot.text = "Yapılacak iş: " + (notText.text ?? "")
        zamanLabel.text = "Zaman: " + (zamanText.text ?? "")
    }
    
    @IBAction func silTiklandi(_ sender: Any) {
        // UserDefaults’tan sil
        UserDefaults.standard.removeObject(forKey: "not")
        UserDefaults.standard.removeObject(forKey: "zaman")
        
        // Label’ları temizle
        labelNot.text = "Yapılacak iş: "
        zamanLabel.text = "Zaman: "
    }
   
}
