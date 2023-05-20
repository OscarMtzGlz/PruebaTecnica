//
//   BankModel.swift
//  OMartinezPruebaTecnica
//
//  Created by MacBookMBA2 on 19/05/23.
//

import Foundation
import CoreData
import UIKit

@available(iOS 13.0, *)
class BankModel {
    
    //funcion get que invoca a la funcion en la clase Network
    func Get() {
        NetworkRequest().GetRequest(url: "https://dev.obtenmas.com/catom/api/challenge/banks") { data, error in
            if data.count > 0 {
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        bank.append(contentsOf: data)
                    }
                }
            }
        }
    }
    
    //Core Data
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //Se guardan los datos en CoreData
    func SaveDB(bank: BankObject){
        do {
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "BankDB", in: context)
            let obj = NSManagedObject(entity: entidad!, insertInto: context)
            obj.setValue(bank.bankName, forKey: "bankName")
            obj.setValue(String(bank.age), forKey: "age")
            obj.setValue(bank.url, forKey: "url")
            obj.setValue(bank.description, forKey: "bankDescription")
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    //Se obtienne los datos
    func GetDB() -> [BankObject] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BankDB")
        var banks = [BankObject]()
        do {
            let reqBank = try! context.fetch(request)
            for obj in reqBank as! [NSManagedObject] {
                var bank = BankObject()
                bank.bankName = (obj.value(forKey: "bankName") as? String)!
                bank.age = Int((obj.value(forKey: "age") as? String)!)!
                bank.url = (obj.value(forKey: "url") as? String)!
                bank.description = (obj.value(forKey: "bankDescription") as? String)!
                banks.append(bank)
            }
        }
        return banks
    }
    //Se eliminan los datos
    func DeleteDB(name: String) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BankDB")
        fetchRequest.predicate = NSPredicate(format: "bankName = %@", name)
        do {
            let test = try! context.fetch(fetchRequest)
            let obj = test[0] as! NSManagedObject
            context.delete(obj)
            do {
                try! context.save()
            }
        }
    }
}
