//
//  LibraryView.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/21.
//

import UIKit

class LibraryView: UIView {
    @IBOutlet weak var collectionView: LibraryCollectionView!
    
    var libraryVM: LibraryVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension LibraryView {
    func setViewModel(_ libraryVM: LibraryVM) {
        self.libraryVM = libraryVM
        collectionView.setViewModel(libraryVM)
        
        libraryVM.getLibraryAuth { [weak self] in
            guard let self = self else { return }
            libraryVM.fetchPhotos(self.collectionView)
        }
    }
}
