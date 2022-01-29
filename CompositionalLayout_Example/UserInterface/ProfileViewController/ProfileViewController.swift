//
//  ProfileViewController.swift
//  CompositionalLayout_Example
//
//  Created by 김우성 on 2022/01/29.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Properties
    var profileCollectionView: UICollectionView! = nil
    var postingImages: [UIImage]! = nil
    
    /*
     "CaseIterable" 프로토콜을 채택함으로서,
     Collection Type처럼 접근이 가능해진다.
     */
    enum Section: String, CaseIterable {
        case profile = "Profile"
        case myPosting = "MyPosting"
    }
    /*
     collectionView의 데이터소스이다.
     이를 통해서 어떻게 cell을 구성할지 결정한다.
     */
    var dataSource: UICollectionViewDiffableDataSource<Section, ProfileItem>! = nil
    
    // MARK: - Initialize
//    convenience init() {
//        self.init()
//    }
}

// MARK: - View Lifecycle
extension ProfileViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
}

// MARK: - Actions
extension ProfileViewController {
    
}

// MARK: - Helpers
extension ProfileViewController {
    
    func configureCollectionView() {
        view.backgroundColor = .white
        
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: generateLayout())
        collectionView.backgroundColor = .red
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        
        collectionView.register(
            ProfileCell.self,
            forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
        
        collectionView.register(
            PostingCell.self,
            forCellWithReuseIdentifier: PostingCell.reuseIdentifier)
        
        self.profileCollectionView = collectionView
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, ProfileItem>(collectionView: profileCollectionView, cellProvider: { collectionView, indexPath, item  -> UICollectionViewCell? in
            
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .profile:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProfileCell.reuseIdentifier,
                    for: indexPath) as? ProfileCell else { fatalError() }
                cell.profileImageView.image = UIImage(named: "fire")
                return cell
            case .myPosting:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PostingCell.reuseIdentifier,
                    for: indexPath) as? PostingCell else { fatalError() }
                cell.profileImageView.image = UIImage(named: "dummy")
                return cell
            }
        })
        
        let snapshot = snapshotForCurrentState()
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}

// MARK: - Generate Custom Layout
extension ProfileViewController {
    /* CollectionView의 Section에 해당하는 레이아웃을 구성한다. */
    func generateLayout() -> UICollectionViewLayout {
        /*
         "NSCollectionLayoutEnvironment" 를 통해서
         이것을 통해서 현재 레이아웃의 상태에 접근이 가능하고,
         이것의 크기가 500보다 크게되면, "wide" 하다고 판단하고,
         그것에 따라서 하위 layout을 변경하거나 조정할 수 있게된다.
         SwiftUI에서 GeoMetryReader 같은 느낌이다.
         */
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int,
             layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            
            // 현재 차지하고 있는 컨테이너의 너비를 확인한다.
            // 만약 500보다 크다면, 가로모드로 판정해서 layout을 결정하도록 도움을 주는 상수이다.
            let isWideView
            = layoutEnvironment.container.effectiveContentSize.width > 500
            
            // CaseIterable 프로토콜을 채택했으므로, 인덱스를 통해 접근한다.
            let sectionLayoutType = Section.allCases[sectionIndex]
            switch sectionLayoutType {
            case .profile:
                return self.generateProfileLayout(isWide: isWideView)
            case .myPosting:
                return self.generateMyPostingLayout(isWide: isWideView)
            }
        }
        return layout
    }
    
    // "NSCollectionLayoutSection" 는 Section 내부의 레이아웃을 구성한다.
    func generateProfileLayout(isWide: Bool) -> NSCollectionLayoutSection {
        // layout에 들어갈 item을 구성한다.
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group을 구성한다.
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitem: item, count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        // section을 구성한다.
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    // "NSCollectionLayoutSection" 는 Section 내부의 레이아웃을 구성한다.
    func generateMyPostingLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    // 데이터소드에 전달할 데이터를 구성한다.
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, ProfileItem> {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,ProfileItem>()
        snapshot.appendSections([Section.profile])
        snapshot.appendItems([exampleProfileItem01])
        
        snapshot.appendSections([Section.myPosting])
        snapshot.appendItems(allProfileItems)
        return snapshot
    }
}


extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section: ", indexPath.section)
        print("Item: ", indexPath.item)
        print("content: ", dataSource.itemIdentifier(for: indexPath)!.title)
    }
}
