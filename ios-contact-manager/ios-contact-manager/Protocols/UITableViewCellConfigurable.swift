//
//  TableViewCellConfiguable.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/8/23.
//

import UIKit

protocol UITableViewCellConfigurable {
    associatedtype T
    
    var title: UILabel! { get set }
    var subTitle: UILabel! { get set }
    
    func configureCell(item: T)
}
