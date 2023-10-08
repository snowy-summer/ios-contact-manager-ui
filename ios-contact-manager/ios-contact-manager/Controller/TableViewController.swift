import UIKit

final class TableViewController: UITableViewController {
    private let contactsModel = ContactsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return ContactTableViewCell() }
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        cell.configureCell(item: contact)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        presentModallyToEditViewContoller(contact, indexPath)
    }
    
    @IBAction func touchAddBarButton(_ sender: UIBarButtonItem) {
        presentModallyToEditViewContoller(nil, nil)
    }
    
    private func presentModallyToEditViewContoller(_ contact: Contact?, _ indexPath: IndexPath?) {
        guard let editViewController = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
        
        editViewController.contact = contact
        editViewController.delegate = self
        editViewController.indexPath = indexPath
        self.present(editViewController, animated: true)
    }
}

extension TableViewController: ContactsManagable {
    func createContact(_ contact: Contact) {
        contactsModel.createContact(contact: contact)
    }
    
    func updateContact(_ contact: Contact, _ indexPath: IndexPath) {
        contactsModel.updateContact(contact: contact, indexPath: indexPath)
    }
}
