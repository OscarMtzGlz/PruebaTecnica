//
//  BankObject.swift
//  OMartinezPruebaTecnica
//
//  Created by MacBookMBA2 on 19/05/23.
//

import Foundation
//Modelo para manejar los datos
struct BankObject: Codable {
    var bankName: String
    var description: String
    var age: Int
    var url: String
    
    init(bankName: String, description: String, age: Int, url: String) {
        self.bankName = bankName
        self.description = description
        self.age = age
        self.url = url
    }
    
    init() {
        self.bankName = ""
        self.description = ""
        self.age = 0
        self.url = ""
    }
}
