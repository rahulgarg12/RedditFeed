//
//  RFInitialViewController.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

final class RFInitialViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFeedVC()
    }
    
    func showFeedVC() {
        let vc = RFFeedViewController.loadFromNib()
        vc.viewModel = RFFeedViewModel()
        
        let rootNC = UINavigationController(rootViewController: vc)
        rootWindow?.rootViewController = rootNC
    }
}

