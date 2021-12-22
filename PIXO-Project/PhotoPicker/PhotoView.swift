//
//  PhotoView.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/20.
//

import Foundation
import UIKit

class PhotoView: UIView {
    @IBOutlet weak var collectionView: PhotoPickerCollectionView!
    @IBOutlet weak var overlayButton: UIButton! {
        didSet {
            overlayButton.layer.cornerRadius = 11.0
        }
    }
    
    var photoPickerVM: PhotoPickerVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension PhotoView {
    func setViewModel(_ photoPickerVM: PhotoPickerVM) {
        self.photoPickerVM = photoPickerVM
        collectionView.setViewModel(photoPickerVM)
    }
}
