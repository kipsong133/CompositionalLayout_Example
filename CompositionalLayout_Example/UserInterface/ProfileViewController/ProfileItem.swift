//
//  ProfileItem.swift
//  CompositionalLayout_Example
//
//  Created by 김우성 on 2022/01/29.
//

import UIKit

class ProfileItem: Hashable {
    let profileImage: UIImage
    let title: String
//    let postings: [PostingItem]
    
    init(profileImage: UIImage, title: String, postings: [PostingItem] = []) {
        self.profileImage = profileImage
        self.title = title
//        self.postings = postings
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: ProfileItem, rhs: ProfileItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
    
}

// dummydata

var allProfileItems: [ProfileItem] {
    return [exampleProfileItem02,exampleProfileItem03,exampleProfileItem04,exampleProfileItem05]
}

let exampleProfileItem01 = ProfileItem(
    profileImage: UIImage(named: "dummy")!,
    title: "fire1",
    postings: [PostingItem(photo: UIImage(named: "dummy")!, title: "불불1")])
let exampleProfileItem02 = ProfileItem(
    profileImage: UIImage(named: "dummy")!,
    title: "fire2",
    postings: [PostingItem(photo: UIImage(named: "dummy")!, title: "불불2")])
let exampleProfileItem03 = ProfileItem(
    profileImage: UIImage(named: "dummy")!,
    title: "fire3",
    postings: [PostingItem(photo: UIImage(named: "dummy")!, title: "불불3")])
let exampleProfileItem04 = ProfileItem(
    profileImage: UIImage(named: "dummy")!,
    title: "fire4",
    postings: [PostingItem(photo: UIImage(named: "dummy")!, title: "불불4")])

let exampleProfileItem05 = ProfileItem(
    profileImage: UIImage(named: "dummy")!,
    title: "fire4",
    postings: [PostingItem(photo: UIImage(named: "dummy")!, title: "불불4")])

