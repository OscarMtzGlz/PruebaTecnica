//
//  TableViewCell.swift
//  OMartinezPruebaTecnica
//
//  Created by MacBookMBA2 on 19/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewImgContainer: UIView!
    @IBOutlet weak var contianerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
