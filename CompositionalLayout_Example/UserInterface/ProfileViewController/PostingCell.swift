//
//  PostingCell.swift
//  CompositionalLayout_Example
//
//  Created by 김우성 on 2022/01/29.
//

import SnapKit
import UIKit

class PostingCell: UICollectionViewCell {
    static let reuseIdentifier = "PostingCell"
    
    let contentContainer = UIView()
    let profileImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.isUserInteractionEnabled = true
        // initialize what is needed
    }
}

extension PostingCell {
    func configure() {
        contentView.addSubview(contentContainer)
        contentContainer.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let x = Int.random(in: 1...10)
        
        contentContainer.backgroundColor = .lightGray
//        profileImageView.image = UIImage(named: x > 5 ? "fire" : "dummy")
        profileImageView.contentMode = .scaleToFill
        contentContainer.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
}
