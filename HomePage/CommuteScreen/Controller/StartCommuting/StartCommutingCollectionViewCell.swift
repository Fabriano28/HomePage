//
//  ActionCollectionViewCell.swift
//  HomePage
//
//  Created by Ricky on 15/06/22.
//

import UIKit

class StartCommutingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var actionImage: UIImageView!
    
    @IBOutlet weak var actionName: UILabel!
    @IBOutlet weak var actionDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var dataDisplayed: action? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        if let data = dataDisplayed {
            actionName.text = data.name
            actionDesc.text = data.desc
            actionImage.image = data.image
            
            
        }
    }
}
