//
//  ViewController.swift
//  AlisverisListesi
//
//  Created by Mustafa Emir Ata on 26.10.2025.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var isimDizi=[String]()
    var idDizi=[UUID]()
    var secilenIsim=""
    var secilenUUID:UUID?
    override func viewDidLoad() {
        
        tableView.delegate=self
        tableView.dataSource=self
        
        
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButonuTiklandi))
        veriAl()
        
  
        
    }
    override func  viewWillAppear(_ _animated:Bool ){
            NotificationCenter.default.addObserver(self, selector: #selector(veriAl), name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
        }
    // veri çekme
    @objc func veriAl(){
        isimDizi.removeAll(keepingCapacity: false)
        idDizi.removeAll(keepingCapacity: false)
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
        fetchRequest.returnsObjectsAsFaults=false
        
        do{
          let sonuclar = try context.fetch(fetchRequest)
            for sonuc in sonuclar as! [NSManagedObject]{
                if let isim = sonuc.value(forKey: "isim") as? String{
                    isimDizi.append(isim)
                }
                if let id = sonuc.value(forKey: "id")as? UUID{
                    idDizi.append(id)
                }
                
            }
            //veri değiştikten sonra güncelleme işlemi
            tableView.reloadData()
            
            
        }catch{
            print("hata oldu")
            
        }
    }
    
    
    
    
    
    
    @objc func eklemeButonuTiklandi(){
        secilenIsim=""
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isimDizi.count
    }
    
    //rowlarda ne gösterilecek
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=isimDizi[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            //hedef tanımla
            let destinationVc=segue.destination as!DetailsViewController
            destinationVc.secilenUrunIsmi=secilenIsim
            destinationVc.secilenUrunUUID=secilenUUID
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ne seçildiyse direkt al.
        secilenIsim=isimDizi[indexPath.row]
        secilenUUID=idDizi[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // 2️⃣ Silme işlemini burada yaparsın
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //veritabanında silmek için ilgili veriyi uuid ye görte çek
            
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            
            let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
            let uuidString=idDizi[indexPath.row].uuidString
            
            fetchRequest.predicate=NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults=false
            
            do{
                let sonuclar = try context.fetch(fetchRequest)
                if  sonuclar.count>0{
                    
                    //tekil sonuca ulaştık
                    for sonuc in sonuclar as! [NSManagedObject]{
                        if let id=sonuc.value(forKey: "id") as? UUID{
                            if id==idDizi[indexPath.row]{
                                context.delete(sonuc)
                                isimDizi.remove(at: indexPath.row)
                                idDizi.remove(at: indexPath.row)
                                
                                self.tableView.reloadData()
                                try context.save()
                            }
                        }
                        
                    }
                }
                
            }catch{
                print("hata")
            }
            
            
        }
        
    }
}


