//
//  LibraryCollectionView.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/21.
//

import UIKit

class LibraryCollectionView: UICollectionView {
    var libraryVM: LibraryVM?
    weak var libraryDelegate: LibraryImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()   // CollectionView 기본 설정
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension LibraryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let libraryVM = libraryVM else { return 0 }
        return libraryVM.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionCell", for: indexPath) as? LibraryCollectionCell else { return UICollectionViewCell() }
        
        guard let libraryVM = libraryVM else { return UICollectionViewCell() }
        cell.imageView.image = libraryVM.images?[indexPath.row]

        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension LibraryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104.0, height: 104.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let libraryVM = libraryVM, let images = libraryVM.images else { return }
        
        // Overlay할 이미지 전달할 Delegate
        libraryDelegate?.sendImage(image: images[indexPath.row])
    }
}

extension LibraryCollectionView {
    // CollectionView 기본 설정
    func configureCollectionView() {
        delegate = self
        dataSource = self
        register(UINib(nibName: "LibraryCollectionCell", bundle: Bundle.main),
                 forCellWithReuseIdentifier: "LibraryCollectionCell")
    }
    
    // Library ViewModel Set
    func setViewModel(_ libraryVM: LibraryVM) {
        self.libraryVM = libraryVM
    }
}
