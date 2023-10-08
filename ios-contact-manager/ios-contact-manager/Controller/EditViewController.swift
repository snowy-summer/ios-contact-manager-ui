import UIKit

protocol ContactsManagable: AnyObject {
    func updateContact(_ contact: Contact, _ indexPath: IndexPath)
    
    func createContact(_ contact: Contact)
}

final class EditViewController: UIViewController {
    weak var delegate: ContactsManagable?
    var contact: Contact?
    var indexPath: IndexPath?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextFeild: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    }
    
    private func configureViewComponents() {
        nameTextField.placeholder = "이름을 입력해주세요."
        ageTextFeild.placeholder = "나이를 입력해주세요."
        phoneNumberTextField.placeholder = "전화번호를 입력해주세요."
        
        if let contact = contact {
            nameTextField.text = contact.name
            ageTextFeild.text = "\(contact.age)"
            phoneNumberTextField.text = "\(contact.phoneNumber)"
        }
    }
    
    @IBAction private func touchSaveBarButton(sender: UIBarButtonItem) {
        guard let contact = contact,
              let indexPath = indexPath,
              let delegate = delegate
        else { return }
        delegate.updateContact(contact, indexPath)
    }
}
