//
//  ViewController.swift
//  Haritalar
//
//  Created by Mustafa Emir Ata on 9.11.2025.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var isimField: UITextField!
    @IBOutlet weak var notField: UITextField!
    @IBOutlet weak var mapview: MKMapView!
    
    var locationManager = CLLocationManager()
    var secilenLatitude=Double()
    var secilenLongitude=Double()
    
    var secilenIsim=""
    var secilenId:UUID?
    
    var annotationTtile=""
    var annotationSubtitle=""
    var annotationLatitude=Double()
    var annotationLongitude=Double()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapview.delegate = self
        locationManager.delegate=self
        mapview.showsUserLocation = true

        
        //ayarlar
        
        //kesknlik
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //konum alma izni
        locationManager.requestAlwaysAuthorization()
        
        //konum güncelleme işlemi
        locationManager.startUpdatingLocation()
        
        
        let gestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(konumSec(gestureRecognizer: )))
        
        // kaç sani,ye basılı tutunca algılaısn
        gestureRecognizer.minimumPressDuration=3
        mapview.addGestureRecognizer(gestureRecognizer)
        
        if secilenIsim != ""{
            // coreData dan çel
            
            if let uuidString=secilenId?.uuidString{
                // yapabiliyorsak eğer;
                let appDelegate=UIApplication.shared.delegate as! AppDelegate
                let context=appDelegate.persistentContainer.viewContext
                
                let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Yer")
                fetchRequest.predicate=NSPredicate(format: "id=%@", uuidString)

                fetchRequest.returnsObjectsAsFaults=false
                
                do
                {
                    let sonuclar=try context.fetch(fetchRequest)
                    
                    if sonuclar.count>0{
                        for sonuc in sonuclar as! [NSManagedObject]{
                            if let isim=sonuc.value(forKey: "isim") as? String{
                                annotationTtile=isim
                                if let not=sonuc.value(forKey: "not")as? String{
                                    annotationSubtitle=not
                                    if let latitude=sonuc.value(forKey: "latitude") as? Double{
                                        annotationLatitude=latitude
                                        if let longitude=sonuc.value(forKey: "longitude") as? Double{
                                            annotationLongitude=longitude
                                            
                                            let annotation=MKPointAnnotation()
                                            annotation.title=annotationTtile
                                            annotation.subtitle=annotationSubtitle
                                            
                                            //koordinat oluştur önce
                                            
                                            let coordinat=CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                            annotation.coordinate=coordinat
                                            
                                            //mapte göster
                                            
                                            mapview.addAnnotation(annotation)
                                            isimField.text=annotationTtile
                                            notField.text=annotationSubtitle
                                            
                                            locationManager.stopUpdatingLocation()
                                            
                                            let span=MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                            let region=MKCoordinateRegion(center: coordinat, span: span)
                                            
                                            mapview.setRegion(region, animated: true)
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    
                }catch{
                    print("hata")
                }
                
            }
            
        }
        else{
            //yeni eklemeye geldi
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reID="benimAnnotation"
        var pinView=mapView.dequeueReusableAnnotationView(withIdentifier: reID)
        
        if pinView == nil{
            pinView=MKPinAnnotationView(annotation: annotation, reuseIdentifier: reID)
            pinView?.canShowCallout=true
            pinView?.tintColor = .blue
            let button=UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView=button
        }
        else
        {
            pinView?.annotation=annotation
        }
        return pinView
    }
    
    // eklediğimiz butona eklenince ne olacağını belirteceğimiz fonksiyon
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if secilenIsim != ""{
            var requestLocation=CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placeMarkDizi,hata) in
                if let placemarks=placeMarkDizi{
                    if placemarks.count>0{
                        let yeniPlaceMark=MKPlacemark(placemark: placemarks[0])
                        let item=MKMapItem(placemark: yeniPlaceMark)
                        
                        item.name=self.annotationTtile
                        
                        // başlangıç olarak arabyala gidiş yöntemini getirelim.
                        let launchOptions=[MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        
                        // haritalarda aç
                        item.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
            }
            
        }
    }
    
    @objc func konumSec(gestureRecognizer:UILongPressGestureRecognizer){
        
        // başladığında ne olacak
        if gestureRecognizer.state == .began{

            let dokunulanNokta=gestureRecognizer.location(in: mapview)
            //koordinate çevir
            let dokunulanKoordinat=mapview.convert(dokunulanNokta, toCoordinateFrom: mapview)
            
            //core data için
            secilenLatitude=dokunulanKoordinat.latitude
            secilenLongitude=dokunulanKoordinat.longitude
            
            
            //artık dokunulan koordinatı biliyoruz.
            
            // işaretleme yapalım
            
            
            let annotation=MKPointAnnotation()
            // çevrim yaptığımız korrdinatı pinliyoruz.
            annotation.coordinate=dokunulanKoordinat
            annotation.title=isimField.text
            annotation.subtitle=notField.text
            
            //mapview 'e ekledik
            mapview.addAnnotation(annotation)
        }
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
        
        if secilenIsim == ""{
            let location=CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
           
            //YÜKSEKLİK VE GENİŞLİK AL -> BÜYÜTÜP KÜÇÜLTME İŞLEMLERİ İÇİN
            let span=MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region=MKCoordinateRegion(center: location, span: span)
            mapview.setRegion(region, animated: true)
        }
        
        
        
        
        
        

    }

    @IBAction func kaydetTiklandi(_ sender: Any) {
        // önce context'e ulaşıla   cak
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        //ad , neyin içine (context)
        let yeniYer=NSEntityDescription.insertNewObject(forEntityName: "Yer", into: context)
        yeniYer.setValue(isimField.text, forKey: "isim")
        yeniYer.setValue(notField.text, forKey: "not")
        yeniYer.setValue(secilenLatitude, forKey: "latitude")
        yeniYer.setValue(secilenLongitude, forKey: "longitude")
        yeniYer.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("kayıt edildi!")
        }catch{
            print("hata var!")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("yeniYerOlusturuldu"), object: nil)
        navigationController?.popViewController(animated: true)


    }
    
}

