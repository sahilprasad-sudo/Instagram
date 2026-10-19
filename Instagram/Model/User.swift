//
//  User.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import Foundation

struct User:Identifiable,Codable,Hashable{
    let id: String
    var username:String
    var profileImageUrl:String?
    var fullname:String?
    var bio:String?
    let email:String
    
}

extension User {
    static var MOCK_USER: [User] = [
        // Original user
        .init(
            id: NSUUID().uuidString,
            username: "blackpanther",
            profileImageUrl: "Image",
            fullname: "Chadwick Boseman",
            bio: "Wakanda Forever",
            email: "blackpanther@gmail.com"
        ),
        // 10 additional mock users
        .init(
            id: NSUUID().uuidString,
            username: "batman",
            profileImageUrl: "Image 9",
            fullname: "Bruce Wayne",
            bio: "Gotham's Dark Knight",
            email: "batman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "ironman",
            profileImageUrl: "Image 10",
            fullname: "Tony Stark",
            bio: "Genius, billionaire, playboy, philanthropist",
            email: "ironman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "venom",
            profileImageUrl: "Image 15",
            fullname: "Eddie Brock",
            bio: "We are Venom",
            email: "venom@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "spiderman",
            profileImageUrl: "Image 12",
            fullname: "Peter Parker",
            bio: "Your friendly neighborhood Spider-Man",
            email: "spiderman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "thor",
            profileImageUrl: "Image 13",
            fullname: "Thor Odinson",
            bio: "God of Thunder, Son of Odin",
            email: "thor@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "captainamerica",
            profileImageUrl: "Image 14",
            fullname: "Steve Rogers",
            bio: "I can do this all day",
            email: "cap@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "doctorstrange",
            profileImageUrl: "Image 15",
            fullname: "Stephen Strange",
            bio: "Master of the Mystic Arts",
            email: "strange@gmail.com"
        )
    ]
}

