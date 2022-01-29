//
//  PostingItem.swift
//  CompositionalLayout_Example
//
//  Created by 김우성 on 2022/01/29.
//


import UIKit

class PostingItem: Hashable {
    let photo: UIImage
    let title: String
    let subitems: [PostingItem]
    
    init(photo: UIImage, title: String, subitems: [PostingItem] = []) {
        self.photo = photo
        self.title = title
        self.subitems = subitems
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PostingItem, rhs: PostingItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
