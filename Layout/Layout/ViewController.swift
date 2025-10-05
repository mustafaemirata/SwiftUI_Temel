//
//  ViewController.swift
//  Layout
//
//  Created by Mustafa Emir Ata on 27.08.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        // Label
        let myLabel = UILabel()
        myLabel.text = "Hello, World!"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width*0.5-50, y: height*0.5-50, width: 100, height: 100)
        view.addSubview(myLabel)
        
        // Button
        let myButton = UIButton(type: .system)
        myButton.setTitle("Benim Butonum", for: .normal)
        myButton.setTitleColor(.cyan, for: .normal)
        myButton.frame = CGRect(x: width*0.5-50, y: height*0.5, width: 100, height: 50)
        myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(myButton)
    }

    @objc func buttonClicked() {
        print("Butona basıldı!")
    }
}
