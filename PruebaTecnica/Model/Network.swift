//
//  Network.swift
//  OMartinezPruebaTecnica
//
//  Created by MacBookMBA2 on 19/05/23.
//

import Foundation

class NetworkRequest {
    //Realiza la petición al endpoint
    func GetRequest(url: String, DataRequest: @escaping([BankObject], Error?) -> Void) {
        do {
            let urlString = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlString!) { data, response, error in
                if let data = data {
                    let bank = try! JSONDecoder().decode([BankObject].self, from: data)
                    DataRequest(bank, nil)
                } else {
                    DataRequest([], error)
                }
            }.resume()
        }
    }
    
}
