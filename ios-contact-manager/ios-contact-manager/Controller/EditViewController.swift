//
//  EditViewController.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/10/23.
//

import UIKit

final class EditViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    
    weak var delegate: ContactsManagable?
    var contact: Contact?
    var indexPath: IndexPath?
    
    private var name: String?
    private var age: Int?
    private var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewComponents()
        self.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text?.replacingOccurrences(of: "-", with: "") else { return }
        textField.text = text.formatted(by: "-")
    }
    
    private func configureViewComponents() {
        self.ageTextField.keyboardType = .numberPad
        self.phoneNumberTextField.keyboardType = .phonePad
        
        if let contact = contact {
            self.nameTextField.text = contact.name
            self.ageTextField.text = "\(contact.age)"
            self.phoneNumberTextField.text = contact.phoneNumber
        }
    }
    
    private func presentRewindCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let noAction = UIAlertAction(title: "아니오", style: .default)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true)
    }
    
    private func presentErrorAlert(_ error: ContactError) {
        let alert = UIAlertController(title: error.description, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
    
    @IBAction private func touchCancelBarButton(_ sender: UIBarButtonItem) {
        self.presentRewindCancelAlert()
    }
    
    @IBAction private func touchSaveBarButton(_ sender: UIBarButtonItem) {
        do {
            try checkNameTextFieldIsValid()
            try checkAgeTextFieldIsValid()
            try checkPhoneNumberTextFieldIsValid()
            self.saveContact()
            guard let contact = contact else { return }
            self.dismiss(animated: true) { [weak self] in
                if let indexPath = self?.indexPath {
                    self?.delegate?.updateContact(contact, indexPath)
                } else {
                    self?.delegate?.createContact(contact)
                }
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
}

// MARK: TextField validation methods
extension EditViewController {
    private func checkNameTextFieldIsValid() throws {
        guard let text = self.nameTextField.text,
              text.isEmpty == false
        else { throw ContactError.invalidName }
        
        self.name = text.replacingOccurrences(of: " ", with: "")
    }
    
    private func checkAgeTextFieldIsValid() throws {
        guard let text = self.ageTextField.text?.replacingOccurrences(of: " ", with: ""),
              let age = Int(text),
              age >= 0 && age < 1000
        else { throw ContactError.invalidAge }
        
        self.age = age
    }
    
    private func checkPhoneNumberTextFieldIsValid() throws {
        guard let text = self.phoneNumberTextField.text?.replacingOccurrences(of: "-", with: ""),
              text.count >= 9,
              let _ = Int(text)
        else { throw ContactError.invalidPhoneNumber }
        
        self.phoneNumber = text.formatted()
    }
    
    private func saveContact() {
        guard let name = self.name,
              let age = self.age,
              let phoneNumber = self.phoneNumber
        else { return }
        
        self.contact = Contact(name: name, age: age, phoneNumber: phoneNumber)
    }
}
