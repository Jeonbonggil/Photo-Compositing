//
//  ViewController.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/20.
//

import UIKit
import SnapKit

protocol PhotoPickerDelegate: AnyObject {
    func sendOverlayImage(image: UIImage?)
}

class PhotoPickerVC: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!  // 메인 이미지
    @IBOutlet weak var overImageView: UIImageView!  // 서브 이미지
    
    let photoPickerVM = PhotoPickerVM()
    var mainImage = UIImage()
    var saveImage = UIImage()
     
    // Photo Picker Controller 닫기
    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // 이미지 합치고 갤러리에 저장하기
    @IBAction func saveAction(_ sender: UIButton) {
        guard let overImg = overImageView.image, let mainImg = mainImageView.image else { return }
        saveImage = mainImg.combineWith(overImg)
        UIImageWriteToSavedPhotosAlbum(saveImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}

//MARK: - Life Cycle
extension PhotoPickerVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (view as! PhotoView).setViewModel(photoPickerVM)
        (view as! PhotoView).collectionView.overlayDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // LibraryVC에서 받은 이미지 메인이미지에 저장
        mainImageView.image = mainImage
    }
}

//MARK: - 갤러리에 이미지 저장하기 Alert 띄우기
extension PhotoPickerVC {
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            let ac = UIAlertController(title: "이미지 저장 실패", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "확인", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "이미지 저장!", message: "사진첩에 이미지가 저장 되었습니다.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "확인", style: .default))
            present(ac, animated: true)
        }
    }
}

//MARK: - 메인이미지 위에 새 이미지 띄우기
extension PhotoPickerVC: PhotoPickerDelegate {
    func sendOverlayImage(image: UIImage?) {
        overImageView?.image = image
        overImageView?.layer.borderWidth = 0.0
        mainImageView.addSubview(overImageView ?? UIImageView())
        
        overImageView?.snp.makeConstraints({ [weak self] in
            guard let self = self else { return }
            $0.centerX.equalTo(self.mainImageView)
            $0.centerY.equalTo(self.mainImageView)
        })
    }
}
