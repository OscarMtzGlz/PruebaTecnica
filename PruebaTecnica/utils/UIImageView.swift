//
//  UIImageView.swift
//  OMartinezPruebaTecnica
//
//  Created by MacBookMBA2 on 20/05/23.
//

import UIKit

class UIImg {}
//Extension UIImage para colocar la imagen desde una URL
extension  UIImageView {
    func loadImg(url: String) {
        guard let url = URL(string: url) else{
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url)else{return}
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
