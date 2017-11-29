import UIKit

class NewContactVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func addNewContact(_ sender: Any) {
        let newName = nameTF.text!
        let newPhone = phoneTF.text!
        if(newName != nil && !newName.isEmpty && newPhone != nil && !newPhone.isEmpty){
            let contactsController = navigationController?.viewControllers.first as! ContactsTVC
            contactsController.contacts.append(Contact(name: newName,phone: newPhone))
            contactsController.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    }
}
