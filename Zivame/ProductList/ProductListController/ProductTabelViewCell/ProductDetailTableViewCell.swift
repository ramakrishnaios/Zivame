//
//  ProductDetailTableViewCell.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductRating: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProductThumbnai: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
