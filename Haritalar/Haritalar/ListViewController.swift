//
//  ListViewController.swift
//  Haritalar
//
//  Created by Mustafa Emir Ata on 11.11.2025.
//

import UIKit
import CoreData

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var isimDizi=[String]()
    var idDizi=[UUID]()
    
    var SecilenYerIsim=""
    var SecilenYerId: UUID?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate=self
        tableView.dataSource=self
        
        //navigasyon bar ekle
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(artiTiklandi))
        veriAl()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(veriAl), name: NSNotification.Name("yeniYerOlusturuldu"), object: nil)
    }
    
    @objc func veriAl(){
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: "Yer")
        request.returnsObjectsAsFaults=false
        
        do
        {
            let sonuclar=try context.fetch(request)
            
            if sonuclar.count>0{
                isimDizi.removeAll(keepingCapacity: false)
                idDizi.removeAll(keepingCapacity: false)

                
                
                for sonuc in sonuclar as! [NSManagedObject]{
                    
                    if let isim=sonuc.value(forKey: "isim")as? String {
                        isimDizi.append(isim)
                        
                    }
                    if let id=sonuc.value(forKey: "id")as? UUID{
                        idDizi.append(id)
                    }
                }
                tableView.reloadData()
            }
            
        }catch{
            print("hata var!")
        }
    }
    
    
    
    @objc func artiTiklandi(){
        SecilenYerIsim=""
        performSegue(withIdentifier: "toMapsVC", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isimDizi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=isimDizi[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SecilenYerIsim=isimDizi[indexPath.row]
        SecilenYerId=idDizi[indexPath.row]
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toMapsVC"{
            let destinationVC=segue.destination as! MapsViewController
            destinationVC.secilenIsim=SecilenYerIsim
            destinationVC.secilenId=SecilenYerId
            
        }
    }


}
