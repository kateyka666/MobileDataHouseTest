//
//  ImageManager.swift
//  MobileDataHouseTest
//
//  Created by Екатерина Боровкова on 29.08.2021.
//

import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(for request : String, completionHandler: @escaping (ImageFromAPI) -> Void) {
        
        let apiString = "https://api.unsplash.com/search/photos?client_id=SFricHxZ7Zm1DWXC6oHmZ1rX2zPogSNJP2SmA-Gz6Rc&page=3&query=\(request)"
        guard let url = URL(string: apiString) else {return}
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let currentImage = try JSONDecoder().decode(ImageFromAPI.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(currentImage)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
