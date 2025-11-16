//
//  ViewController.swift
//  HaberProjesi
//
//  Created by Mustafa Emir Ata on 16.11.2025.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private var newTableViewModel:NewsTableView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate=self
        tableView.dataSource=self
        
        
        
        veriAl()
    }
    
    func veriAl(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/BTK-iOSDataSet/refs/heads/master/dataset.json")
        
        guard let url = url else {
            print("Geçersiz URL")
            return
        }
        
        WebService().haberleriIndir(url: url) { (haberler) in
            if let haberler = haberler {
                self.newTableViewModel = NewsTableView(newList: haberler)
                print("Haber sayısı: \(haberler.count)")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Haberler alınamadı")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTableViewModel == nil ? 0 : self.newTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        let newsViewModel=self.newTableViewModel.newsAtIndexPath(_index: indexPath.row)
        
        cell.tittleLabel.text=newsViewModel.title
        cell.storyLabel.text=newsViewModel.story
        
        return cell
    }
}

