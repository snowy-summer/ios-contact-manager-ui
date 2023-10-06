# 연락처 앱 프로젝트 [Step 1] SwainYun, Bum

@ehgud0670

## 참여자 : SwainYun, Bum
|[SwainYun](https://github.com/Remaked-Swain)|[Bum](https://github.com/snowy-summer)|
|:--:|:--:|
|<img src="https://avatars.githubusercontent.com/u/99116619?v=4" width=300>|<img src="https://avatars.githubusercontent.com/u/118453865?v=4" width=300>|


----------------------------------------

## 프로젝트 진행 중 고민한 내용
* **UITableVIewController vs UIViewController**
테이블 뷰를 구현하는 방식
    1. 기존의 ViewController에 테이블 뷰를 따로 만들어서 하는 방식
    ```swift
    import UIKit

    final class ViewController: UIViewController {
        @IBOutlet weak var tableView: UITableView!

        private var contactsModel: ContactsModel!

        override func viewDidLoad() {
            super.viewDidLoad()
            configure()
        }

        private func configure() {
            self.contactsModel = ContactsModel()
        }
    }

    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
            let contact = self.contactsModel.readContact(indexPath: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "\(contact.name)(\(contact.age))"
            content.secondaryText = "\(contact.phoneNumber)"
            cell.contentConfiguration = content

            return cell
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contactsModel.count
        }
    }

    ```
    
    2. TableViewController를 사용하는 방식
    ```swift
    final class TableViewController: UITableViewController {
    private var contactsModel: ContactsModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.contactsModel = ContactsModel()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(contact.name)(\(contact.age))"
        content.secondaryText = "\(contact.phoneNumber)"
        cell.contentConfiguration = content
        
        return cell
    }
    
    // 생략...
    ```
> 어떤 기준으로 UITableViewController와 UIVIewController를 사용해서 TableVIew를 구현하는지 모르겠습니다.
> UITableViewController 문서를 보니 이미 UIViewController를 상속받고 있고 Delegate와 DataSource 프로토콜을 채택하고 있었습니다.

* **Cell Customizing**
테이블 뷰의 셀을 표현하는 방법에 관하여
    1. cell.textLabel?.text에 값을 대입하는 방식
    2. 먼저 내용을 설정한 후 cell.contentConfiguration에 설정한 내용을 대입하는 방식
> 1번 방식의 경우 deprecated 되었습니다. 이의 대안으로 2번 방식을 알게 되었습니다.
> cell의 기본적인 구성(default nil)을 본따서 text, secondaryText 등을 세팅하고 이것을 cell에 넣어주는 식으로 이해하였습니다.
> 어떤 배경에서 1번 방식이 deprecated 되었는지, 그리고 2번 방식으로 얻을 수 있는 이점이 무엇일지 궁금합니다.
