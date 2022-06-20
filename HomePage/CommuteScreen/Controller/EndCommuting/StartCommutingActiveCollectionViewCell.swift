//
//  ActionActiveCollectionViewCell.swift
//  HomePage
//
//  Created by Ricky on 16/06/22.
//

import UIKit

class StartCommutingActiveCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionName: UILabel!
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
            actionImage.image = data.image
            
            
        }
    }

}
