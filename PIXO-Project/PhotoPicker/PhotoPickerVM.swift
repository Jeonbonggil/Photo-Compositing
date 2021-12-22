//
//  PhotoPickerVM.swift
//  PIXO-Project
//
//  Created by Bonggil Jeon on 2021/12/20.
//

import UIKit

class PhotoPickerVM {
    
    func setImage(index: Int) -> UIImage {
        if index < 9 {
            return UIImage(named: "00\(index + 1)")!
        } else {
            return UIImage(named: "0\(index + 1)")!
        }
    }
}
