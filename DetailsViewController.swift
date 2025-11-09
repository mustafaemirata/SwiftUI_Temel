//
//  DetailsViewController.swift
//  AlisverisListesi
//
//  Created by Mustafa Emir Ata on 26.10.2025.
//

import UIKit
import CoreData

// Gerekli protokolleri eklediğinizden emin olun (orijinal kodunuzda bu zaten vardı, doğru)
class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isimField: UITextField!
    @IBOutlet weak var fiyatField: UITextField!
    @IBOutlet weak var bedenField: UITextField!
    
    @IBOutlet weak var kaydetButton: UIButton!
    var secilenUrunIsmi=""
    var secilenUrunUUID:UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if secilenUrunIsmi != ""{
            
            // kaydet butonunu gizledik
            kaydetButton.isHidden=true
            
            
            //Core data ile çek
            print(secilenUrunUUID) //optional olarak gelecek
            
            if let uuidString = secilenUrunUUID?.uuidString{
                
                // app delegate tanımla
                
                let appDelegate=UIApplication.shared.delegate as! AppDelegate
                let context=appDelegate.persistentContainer.viewContext
                let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
                
                //filtre ekle -> mantıksal sınırlar koyacağız.
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)

                fetchRequest.returnsObjectsAsFaults=false
                
                do{
                    let sonuclar=try context.fetch(fetchRequest)
                    
                    if sonuclar.count>0{
                        for sonuc in sonuclar as! [NSManagedObject]{
                            if let isim=sonuc.value(forKey: "isim")as? String{
                                isimField.text=isim
                            }
                            
                            if let fiyat=sonuc.value(forKey: "fiyat")as? Int{
                                fiyatField.text = String(fiyat)
                            }
                            if let beden=sonuc.value(forKey: "beden")as? String{
                                bedenField.text=beden
                            }
                            if let gorselData=sonuc.value(forKey: "gorsel")as? Data{
                                //resme çevir
                                let image=UIImage(data: gorselData)
                                imageView.image=image
                            }
                        }
                        
                    }
                    
                }catch{
                    print("hata var")
                }
                
                
                
               
            }
            
        }else{
            kaydetButton.isHidden=false
            kaydetButton.isEnabled=false
            isimField.text=""
            fiyatField.text=""
            bedenField.text=""
        }
        
        // 1. Klavye kapatma
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
        
       
        imageView.isUserInteractionEnabled = true
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        
       
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        
        //fonksiyonlarına ulaşabilmek için delegate
        picker.delegate = self
        
        //kaynak belirt
        picker.sourceType = .photoLibrary
        
        //kullanıcının düzenleme işlemlerine izin verilmesi
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    // Fotoğraf seçildiğinde veya düzenlendiğinde çalışan fonksiyon
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
      
        imageView.image = info[.editedImage] as? UIImage
        
        //kullanıcı görsel seçtiği zaman kaydet butonu aktif olur
        kaydetButton.isEnabled=true
        
        //image view controller'ı kapat
        self.dismiss(animated: true, completion: nil)
        
       
    }
    
    @IBAction func kaydetButonTiklandi(_ sender: Any) {
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let alisveris=NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context)
        
        alisveris.setValue(isimField.text!, forKey: "isim")
        alisveris.setValue(bedenField.text!, forKey: "beden")
        
        if let fiyat=Int(fiyatField.text!){
            alisveris.setValue(fiyat, forKey: "fiyat")
        }
        // UUID
        alisveris.setValue(UUID(), forKey: "id")
        
        let data=imageView.image!.jpegData(compressionQuality: 0.5)
        alisveris.setValue(data, forKey: "gorsel")
        
        // save et
        do{
            try context.save()
            print("kayıt edildi!")
        }catch{
            print("hata var!")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"veriGirildi"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)
    }
}
