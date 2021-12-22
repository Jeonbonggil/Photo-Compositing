//
//  UIImage.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/22.
//

import UIKit

extension UIImage {
    // 어디서든 사용할 수 있도록 extension으로 이동
    // 이미지 합치기 function
    func combineWith(_ subImage: UIImage) -> UIImage {
        let mainImgaeSize = CGSize(width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(mainImgaeSize, false, 0.0)
        
        draw(in: CGRect(x: 0, y: 0, width: mainImgaeSize.width, height: mainImgaeSize.height))
        subImage.draw(in: CGRect(x: mainImgaeSize.width / 4.0,
                                 y: mainImgaeSize.height / 4.0,
                                 width: mainImgaeSize.width / 2.0,
                                 height: mainImgaeSize.height / 2.0))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
