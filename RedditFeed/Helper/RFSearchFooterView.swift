//
//  RFSearchFooterView.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

final class RFSearchFooterView: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }
    
    func setNotFiltering() {
        label.text = ""
        hideFooter()
    }
    
    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if filteredItemCount == totalItemCount {
            setNotFiltering()
        } else if filteredItemCount == 0 {
            label.text = "No items match the query"
            showFooter()
        } else {
            label.text = "Filtering \(filteredItemCount) of \(totalItemCount)"
            showFooter()
        }
    }
    
    private func hideFooter() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0.0
        }
    }
    
    private func showFooter() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
    }
    
    private func configureView() {
        backgroundColor = UIColor.green
        alpha = 0.0
        
        label.textAlignment = .center
        label.textColor = .white
        addSubview(label)
    }
}
