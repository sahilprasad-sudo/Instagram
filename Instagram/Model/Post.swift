//
//  Post.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import Foundation

struct Post:Identifiable,Hashable,Codable{
    let id:String
    let ownerUid:String
    let caption:String
    var likes:Int
    let imageUrl:String
    let timestamp:Date
    var user:User?
    
}

extension Post {
    static var MOCK_Posts:[Post] = [
        .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[0].id,
                    caption: "Wakanda Forever! Protecting the kingdom.",
                    likes: 1240,
                    imageUrl: "Image",
                    timestamp: Date(),
                    user: User.MOCK_USER[0]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[1].id,
                    caption: "Gotham never sleeps, and neither do I.",
                    likes: 856,
                    imageUrl: "Image 9",
                    timestamp: Date().addingTimeInterval(-3600), // 1 hour ago
                    user: User.MOCK_USER[1]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[2].id,
                    caption: "Testing out the new Mark LXXXV armor in the lab.",
                    likes: 3420,
                    imageUrl: "Image 10",
                    timestamp: Date().addingTimeInterval(-7200), // 2 hours ago
                    user: User.MOCK_USER[2]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[3].id,
                    caption: "Eyes, lungs, pancreas... so many snacks, so little time.",
                    likes: 412,
                    imageUrl: "Image 15",
                    timestamp: Date().addingTimeInterval(-14400), // 4 hours ago
                    user: User.MOCK_USER[3]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[4].id,
                    caption: "Just swinging through Queens! Caught a great view from the top of the Chrysler Building.",
                    likes: 1890,
                    imageUrl: "Image 12",
                    timestamp: Date().addingTimeInterval(-28800), // 8 hours ago
                    user: User.MOCK_USER[4]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[5].id,
                    caption: "Another glorious day in New Asgard. Bring me another coffee!",
                    likes: 2150,
                    imageUrl: "Image 13",
                    timestamp: Date().addingTimeInterval(-43200), // 12 hours ago
                    user: User.MOCK_USER[5]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[6].id,
                    caption: "Morning run around D.C. On your left!",
                    likes: 1530,
                    imageUrl: "Image 14",
                    timestamp: Date().addingTimeInterval(-86400), // 1 day ago
                    user: User.MOCK_USER[6]
                ),
                .init(
                    id: NSUUID().uuidString,
                    ownerUid: User.MOCK_USER[7].id,
                    caption: "Studying the Book of Vishanti at the Sanctum Sanctorum.",
                    likes: 945,
                    imageUrl: "Image 15",
                    timestamp: Date().addingTimeInterval(-172800), // 2 days ago
                    user: User.MOCK_USER[7]
                )
            ]
}
