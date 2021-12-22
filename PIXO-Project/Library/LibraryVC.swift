//
//  LibraryVC.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/21.
//

import UIKit

protocol LibraryImageDelegate: AnyObject {
    func sendImage(image: UIImage)  // 이미지 전달
}

class LibraryVC: UIViewController {
    let libraryVM = LibraryVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (view as! LibraryView).setViewModel(libraryVM)        
        (view as! LibraryView).collectionView.libraryDelegate = self
    }
}

//MARK: - 선택한 Image를 PhotoPickerVC로 전달 및 이동
extension LibraryVC: LibraryImageDelegate {
    func sendImage(image: UIImage) {
        guard let photoVC = storyboard?.instantiateViewController(withIdentifier: "PhotoPickerVC") as? PhotoPickerVC else { return }
        photoVC.modalPresentationStyle = .fullScreen
        photoVC.mainImage = image
        self.present(photoVC, animated: true, completion: nil)
    }
}
