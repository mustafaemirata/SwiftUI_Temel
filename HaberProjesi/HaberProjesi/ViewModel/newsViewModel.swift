//
//  newsViewModel.swift
//  HaberProjesi
//
//  Created by Mustafa Emir Ata on 16.11.2025.
//

import Foundation

struct NewsTableView {
    let newList: [News]
    
    func numberOfRowsInSection() -> Int {
        return self.newList.count
    }
    
    // diziden tekilde dönüştürdük
    func newsAtIndexPath(_index: Int) -> NewsViewModel {
        let news = self.newList[_index]
        return NewsViewModel(news: news)
    }
}

// tekil işlemler
struct NewsViewModel {
    let news: News
    
    var title: String {
        return self.news.title
    }
    
    var story: String {
        return self.news.story
    }
}

