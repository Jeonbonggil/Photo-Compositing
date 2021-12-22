//
//  PhotoPickerColllectionView.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/20.
//

import UIKit

class PhotoPickerCollectionView: UICollectionView {
    var photoPickerVM: PhotoPickerVM?
    weak var overlayDelegate: PhotoPickerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()   // CollectionView 기본 설정
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PhotoPickerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPickerCell", for: indexPath) as? PhotoPickerCell else { return UICollectionViewCell() }
        
        cell.imageView.image = photoPickerVM?.setImage(index: indexPath.row)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoPickerCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = photoPickerVM?.setImage(index: indexPath.row)
        
        // Main Image에 sub Image 덮어쓰기 delegate
        overlayDelegate?.sendOverlayImage(image: image)
    }
}

extension PhotoPickerCollectionView {
    // CollectionView 기본 설정
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        
        dataSource = self
        delegate = self
        register(UINib(nibName: "PhotoPickerCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PhotoPickerCell")
    }
    
    // PhotoPicker ViewModel Set
    func setViewModel(_ photoPickerVM: PhotoPickerVM) {
        self.photoPickerVM = photoPickerVM
    }
}
