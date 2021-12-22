//
//  PhotoPickerCell.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/20.
//

import UIKit

class PhotoPickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
