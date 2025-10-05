//
//  ViewController.swift
//  Sayaclar
//
//  Created by Mustafa Emir Ata on 5.10.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var timer = Timer()
    var kalanZaman = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Başlangıç zamanı
        kalanZaman = 15
        label.text = "Zaman: \(kalanZaman)"
    }

    @IBAction func baslatTiklandi(_ sender: Any) {
        // Timer'ı başlat
        timer.invalidate() // Eğer daha önce çalışıyorsa durdur
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFonksiyonu), userInfo: nil, repeats: true)
    }
    
    @objc func timerFonksiyonu() {
        label.text = "Zaman: \(kalanZaman)"
        kalanZaman -= 1
        
        if kalanZaman < 0 {
            //timer durdurma işlemi
            timer.invalidate()
            label.text = "Süre doldu!"
        }
    }
}
