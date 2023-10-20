import Foundation

final class ContactsModel {
     private var contactsList = [Contact]() {
        didSet {
            self.notifyContactsDidChange()
        }
    }
    
    var filteredContactsList: (_ name: String) -> [Contact] {
        self.filterContact
    }

    var count: Int {
        self.contactsList.count
    }
}

// MARK: CRUD Methods
extension ContactsModel {
    func createContact(contact: Contact) {
        let contact = Contact(name: contact.name, age: contact.age, phoneNumber: contact.phoneNumber, index: self.contactsList.endIndex - 1)
        self.contactsList.append(contact)
    }
    
    func readContact(index: Int) -> Contact {
        return self.contactsList[index]
    }
    
    func updateContact(contact: Contact) {
        guard let index = contact.index else { return }
        self.contactsList[index] = contact
    }
    
    func deleteContact(contact: Contact) {
        guard let index = contact.index else { return }
        self.contactsList.remove(at: index)
    }
    
    func deleteContact(index: Int) {
        self.contactsList.remove(at: index)
    }
    
    private func filterContact(by name: String) -> [Contact] {
        return self.contactsList.filter({$0.name.localizedCaseInsensitiveContains(name)})
    }
}

// MARK: Observer Pattern Methods by using Notification Center
extension ContactsModel {
    private func notifyContactsDidChange() {
        let notificationName = NotificationType.contactsDidChange.name
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
    }
}
