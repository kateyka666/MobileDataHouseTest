//
//  ImageCollectionViewCell.swift
//  MobileDataHouseTest
//
//  Created by Екатерина Боровкова on 29.08.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var requestImageView: UIImageView! {
        didSet {
            requestImageView.contentMode = .scaleAspectFill
        }
    }
}
