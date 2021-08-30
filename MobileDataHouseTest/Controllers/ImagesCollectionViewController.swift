//
//  ImagesCollectionViewController.swift
//  MobileDataHouseTest
//
//  Created by Екатерина Боровкова on 29.08.2021.
//

import UIKit

class ImagesCollectionViewController: UICollectionViewController {
    
    var results = [Result]()
    var textRequest: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        fetchImageFromAPI(text: textRequest)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        let currentImageURL =  results[indexPath.row].user.profileImage.large
        guard let imageURL = URL(string: currentImageURL) else { return cell }
        guard let imageData = try? Data(contentsOf: imageURL) else { return cell }
        
        DispatchQueue.main.async {
        cell.requestImageView.image  = UIImage(data: imageData)
        }
        
        return cell
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageAtRow: CGFloat = 4
        let padding = 20 * (imageAtRow + 1)
        let freeWidth = collectionView.frame.width - padding
        let widthForImage = (freeWidth / imageAtRow).rounded(.down)
        return CGSize(width: widthForImage, height: widthForImage)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

extension ImagesCollectionViewController{
    
    private func fetchImageFromAPI(text: String?){
        guard let text = text else { return }
        
        DispatchQueue.global().async {
            ImageManager.shared.fetchImage(for: text) { [weak self] imagesFromAPI in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.results = imagesFromAPI.results
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
