//
//  RFDetailsViewController.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit
import Combine

final class RFDetailsViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellType: RFDetailsCollectionCell.self)
            
            collectionView.isPagingEnabled = true
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.prefetchDataSource = self
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!
    @IBOutlet private weak var awardsLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    
    var viewModel: RFDetailsViewModel?
    
    private lazy var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel?.title
        authorLabel.text = viewModel?.authorName
        createdAtLabel.text = viewModel?.createdAt
        awardsLabel.text = viewModel?.awards
        scoreLabel.text = viewModel?.score
        commentsCountLabel.text = viewModel?.commentsCount
        
        setNavigationBar()
    }
    
    //MARK: Helper Methods
    func setNavigationBar() {
        title = UIViewTitles.Details.headingTitle
        
        setBookmarkButton()
    }
    
    func setBookmarkButton(image: String? = nil) {
        let imageNamed: String
        if let image = image {
            imageNamed = image
        } else {
            if let isBookmarked = viewModel?.isBookmarked(), isBookmarked {
                imageNamed = "bookmarkRed"
            } else {
                imageNamed = "bookmarkGrey"
            }
        }
        
        //TODO: Handle with Declarative Programming
        let bookmarkButton = UIBarButtonItem(image: UIImage(named: imageNamed), style: .plain, target: self, action: #selector(didTapBookmark(_:)))
        navigationItem.rightBarButtonItem = bookmarkButton
    }
    
    //MARK: Selector Methods
    @objc private func didTapBookmark(_ sender: UIButton) {
        if let isBookmarked = viewModel?.isBookmarked(), isBookmarked {
            viewModel?.deleteBookmark()
            setBookmarkButton(image: "bookmarkGrey")
        } else {
            viewModel?.saveBookmark()
            setBookmarkButton(image: "bookmarkRed")
        }
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension RFDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: RFDetailsCollectionCell.self, for: indexPath)
        
        if let images = viewModel?.images, images.count > indexPath.item {
            cell.object = images[indexPath.item]
        }
        
        return cell
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension RFDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


//MARK:- UITableViewDataSourcePrefetching
extension RFDetailsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel?.prefetchImages(at: indexPaths)
    }
}
