//
//  ImageFromAPI.swift
//  MobileDataHouseTest
//
//  Created by Екатерина Боровкова on 29.08.2021.
//
import Foundation

// MARK: - ImageFromAPI
struct ImageFromAPI: Codable {
    
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Result: Codable {

    let user: User

    enum CodingKeys: String, CodingKey {
        case user
    }
}


// MARK: - User
struct User: Codable {
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
    
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}


