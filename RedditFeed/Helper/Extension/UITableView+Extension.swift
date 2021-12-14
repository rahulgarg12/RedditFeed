//
//  UITableView+Extension.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

extension UITableView {
    func register<T: RFTableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: RFTableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    
    func dequeueReusableCell<T: RFTableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
        cell.indexPath = indexPath
        return cell
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: bounds.size.width, height: bounds.size.height-40))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func removeEmptyMessage() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

