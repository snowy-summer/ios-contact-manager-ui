import UIKit

final class TableViewController: UITableViewController {
    private let contactsModel: ContactsModel = ContactsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        cell.configureCell(item: contact)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        self.presentModallyEditViewController(contact, indexPath)
    }
    
    @IBAction private func touchAddBarButton(_ sender: UIBarButtonItem) {
        self.presentModallyEditViewController(nil, nil)
    }
    
    private func presentModallyEditViewController(_ contact: Contact?, _ indexPath: IndexPath?) {
        guard let editViewController = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
        
        editViewController.delegate = self
        editViewController.indexPath = indexPath
        editViewController.contact = contact
        
        self.present(editViewController, animated: true)
    }
}

extension TableViewController: ContactsManagable {
    func createContact(_ contact: Contact) {
        self.contactsModel.createContact(contact: contact)
        self.tableView.reloadData()
    }
    
    func updateContact(_ contact: Contact, _ indexPath: IndexPath) {
        self.contactsModel.updateContact(contact: contact, indexPath: indexPath)
        self.tableView.reloadData()
    }
}
