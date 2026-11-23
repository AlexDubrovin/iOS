//
//  ViewModel.swift
//  MVVM project
//
//  Created by Sanya on 23.11.2026.
//

import SwiftUI

//Данная запись значит, что класс ViewModel будет доступен исключительно для файла ContentView
extension ContentView{
    @Observable class ViewModel{
        private let networkManager = NetworkManager() //экземпляр класса NetworkManager
        var searchText: String = "" //Поисковый текст
        private(set) var news: [News] = [] //Сами новости, устанавливать(заполнять массив) можно только здесь в этом классе а просматривать где угодно
        
        func sendRequest(){
            networkManager.sendRequest(q: searchText){ result in
                switch result{
                case .success(let news):
                    self.news = news
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

