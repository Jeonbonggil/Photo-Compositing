//
//  LibraryVM.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/21.
//

import Photos
import UIKit

class LibraryVM {
    var images: Array<UIImage>? = [UIImage]()   // 갤러리에서 가져온 이미지 저장할 변수
    
    // CollectionsView의 Cell 갯수
    func numberOfItems() -> Int {
        guard let images = images else { return 0 }
        return images.count
    }
    
    // 갤러리 권한 허용 체크
    func getLibraryAuth(_ completion: @escaping () -> () ) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                
                print("앨범 접근 승인")
                print("image 갯수: \(allPhotos.count)")
            case .denied, .restricted:
                print("앨범 접근 불가")
            case .notDetermined:
                print("접근 여부 미결정 상태")
            case .limited:
                print("Limited")
            @unknown default:
                fatalError()
            }
            
            completion()
        }
    }
    
    // 갤러리에 있는 사진들 가져오기
    func fetchPhotos(_ collectionView: UICollectionView) {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true     // 갤러리 순서대로 불러오기
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 104.0, height: 104.0)
                
                // 이미지 정보 얻어오기
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { [weak self] (image, _) in
                    guard let self = self else { return }
                    
                    if let image = image {
                        self.images?.append(image)
                    } else {
                        print("error asset to image")
                    }
                    
                    if i == results.count - 1 {
                        DispatchQueue.main.async {
                            collectionView.reloadData()
                        }
                    }
                }
            }
        } else {
            print("노출할 사진 없음")
        }
    }
    
}
