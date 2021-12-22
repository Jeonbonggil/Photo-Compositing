//
//  LibraryCollectionCell.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/21.
//

import UIKit

class LibraryCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 16.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
