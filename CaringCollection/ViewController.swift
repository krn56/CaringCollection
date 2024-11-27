//
//  ViewController.swift
//  CaringCollection
//
//  Created by Роман Крендясов on 27.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private static let itemSize: CGSize = .init(width: 300, height: 400)
    private static let itemSpacing: CGFloat = 16
    
    // MARK: - Views
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Self.itemSize
        layout.minimumLineSpacing = Self.itemSpacing
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViews()
    }
    
    private func configureViews() {
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        collectionViewLayout.sectionInset.left = collectionView.layoutMargins.left
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 14
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let itemWidth = Self.itemSize.width + Self.itemSpacing
        let contentOffset = targetContentOffset.pointee.x + Self.itemSpacing
        let itemToScroll = round(contentOffset / itemWidth)
        
        targetContentOffset.pointee = CGPoint(x: itemToScroll * itemWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
    }
}


