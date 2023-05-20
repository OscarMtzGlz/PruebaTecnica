//
//  ViewController.swift
//  PruebaTecnica
//
//  Created by MacBookMBA2 on 20/05/23.
//

import UIKit
//variable global
var bank = [BankObject]()

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    let bankModel = BankModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.separatorColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.tableView.addGestureRecognizer(tap)
        self.tableView.isUserInteractionEnabled = true
    }
    //funcion para mostrar una alerta cuando se presiona una celda
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.tableView.indexPathForRow(at: sender.location(in: self.tableView)) {
            let alert = UIAlertController(title: bank[indexPath.row].bankName, message: "Age: \(bank[indexPath.row].age)", preferredStyle: .alert)
            let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
            let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
            alert.view.addConstraint(height)
            alert.view.addConstraint(width)
            let imageView = UIImageView(frame: CGRect(x: 40, y: 70, width: 200, height: 190))
            
            let bankCore = bankModel.GetDB()
            if bankCore.count > 0 {
                let imageData = Data(base64Encoded: bankCore[indexPath.row].url, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                imageView.image = UIImage(data: imageData!)
            } else {
                imageView.loadImg(url: bank[indexPath.row].url)
            }
            
            alert.view.addSubview(imageView)
            let ok = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let bankDB = bankModel.GetDB()
        if bankDB.count > 0 {
            for i in 0..<bankDB.count {
                bankModel.DeleteDB(name: bankDB[i].bankName)
            }
        }
        Validar()
    }
    //función para validar de donde provienen los datos
    func Validar() {
        let bankDB = bankModel.GetDB()
        if bankDB.count > 0 {
            bank = []
            bank = bankDB
            print(bank[0].url)
            tableView.reloadData()
        } else {
            bankModel.Get()
            DispatchQueue.global().asyncAfter(deadline: .now()+0.8) {
                DispatchQueue.main.async {
                    if bank.count > 0 {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}
@available(iOS 13.0, *)
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bank.count > 0 {
            return bank.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        
        cell.contianerView.layer.cornerRadius = 20
        cell.contianerView.layer.borderWidth = 0.9
        cell.contianerView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        cell.contianerView.layer.backgroundColor = UIColor(named: bank[indexPath.row].bankName)?.withAlphaComponent(0.3).cgColor
        cell.viewImgContainer.layer.cornerRadius = 20
        if bank[indexPath.row].bankName == "Scotiabank México" {
            cell.viewImgContainer.layer.backgroundColor = UIColor.white.cgColor
        } else {
            cell.viewImgContainer.layer.backgroundColor = UIColor(named: bank[indexPath.row].bankName)?.cgColor
        }
        let DataBank = bankModel.GetDB()
        if DataBank.count < DataBank.count+1 && DataBank.count < 5 {
            cell.imgView.loadImg(url: bank[indexPath.row].url)
            DispatchQueue.global().async { [self] in
                let imageData = try! Data(contentsOf: URL(string: bank[indexPath.row].url)!)
                let imageString = imageData.base64EncodedString(options: .lineLength64Characters)
                
                bankModel.SaveDB(bank: BankObject(bankName: bank[indexPath.row].bankName, description: bank[indexPath.row].description, age: bank[indexPath.row].age, url: imageString))
            }
            
        } else {
            cell.imgView.isHidden = true
            let imageData = Data(base64Encoded: bank[indexPath.row].url, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.imgView.image = UIImage(data: imageData!)
            cell.imgView.isHidden = false
        }
        

        cell.nameLabel.text = bank[indexPath.row].bankName
        cell.nameLabel.textColor = UIColor(named: bank[indexPath.row].bankName)
        cell.descriptionLabel.text = bank[indexPath.row].description
        return cell
    }
}

