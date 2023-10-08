//
//  ContactTableViewCell.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/5/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
