//
//  WebService.swift
//  HaberProjesi
//
//  Created by Mustafa Emir Ata on 16.11.2025.
//

import Foundation

class WebService {
    
    func haberleriIndir(url: URL, completion: @escaping ([News]?) -> () ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("İstek hatası: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Veri yok")
                completion(nil)
                return
            }
            
            do {
                let haberlerDizisi = try JSONDecoder().decode([News].self, from: data)
                completion(haberlerDizisi)
            } catch {
                print("JSON decode hatası: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

