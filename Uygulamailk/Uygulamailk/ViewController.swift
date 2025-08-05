//
//  ViewController.swift
//  Uygulamailk
//
//  Created by Mustafa Emir Ata on 6.08.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var benimLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonClicked(_ sender: Any) {
        benimLabel.text="Şampiyon Fenerbahçe!"
    }
    @IBOutlet weak var resim: UIImageView!
}

