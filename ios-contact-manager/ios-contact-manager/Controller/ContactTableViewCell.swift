//
//  ContactTableViewCell.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/5/23.
//

import UIKit

final class ContactTableViewCell: UITableViewCell, UITableViewCellConfigurable {
    typealias T = Contact
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(item contact: Contact) {
        self.title.text = "\(contact.name)(\(contact.age))"
        self.title.font = UIFont.preferredFont(forTextStyle: .headline)
        self.title.adjustsFontForContentSizeCategory = true
        self.subTitle.text = "\(contact.phoneNumber)".formatted(.phoneNumber)
        self.subTitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.subTitle.adjustsFontForContentSizeCategory = true
    }
}
