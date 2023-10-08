//
//  ContactsModel.swift
//  ios-contact-manager-ui
//
//  Created by Swain Yun on 10/4/23.
//

import Foundation

struct Contact {
    let name: String
    let age: Int
    let phoneNumber: Int
}

final class ContactsModel {
    private var contactsList: [Contact] = DeveloperPreview.instance.mockContacts
    
    var count: Int {
        self.contactsList.count
    }
}

// MARK: CRUD Methods
extension ContactsModel {
    func createContact(contact: Contact) {
        self.contactsList.append(contact)
    }
    
    func readContact(indexPath: IndexPath) -> Contact {
        return self.contactsList[indexPath.row]
    }
    
    func updateContact(contact: Contact, indexPath: IndexPath) {
        self.contactsList[indexPath.row] = contact
    }
    
    func deleteContact(indexPath: IndexPath) {
        self.contactsList.remove(at: indexPath.row)
    }
}
