import UIKit

class ContactsTVC: UITableViewController {

    var contacts = [Contact]()
    var sections = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts.append(Contact(name: "grandma", phone: "241-***"))
        contacts.append(Contact(name: "police", phone: "102"))
        contacts.append(Contact(name: "bb", phone: "+7(910)***"))
        contacts.append(Contact(name: "me", phone: "+7(910)***"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        updateSections()
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return String(sections[section])
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfContactsInSection(sectionNumber: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let currentContact = contactsFromSection(sectionNumber: indexPath.section)[indexPath.row]
        
        cell.textLabel?.text = currentContact.name
        cell.detailTextLabel?.text = currentContact.phone
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toRemove = contactsFromSection(sectionNumber: indexPath.section)[indexPath.row]
            contacts.remove(at: contacts.index(of: toRemove)!)
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactsFromSection(sectionNumber: indexPath.section)[indexPath.row]
        let alert = UIAlertController(title: "calling " + contact.name, message: contact.phone, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "k", style: .default))
        present(alert, animated: true)
        
        let historyController = tabBarController?.viewControllers![1] as! HistoryTVC
        let newHistoryUnit = HistoryUnit(date: Date(timeIntervalSinceNow: 0), contact: contact)
        historyController.history.append(newHistoryUnit)
        historyController.tableView.reloadData()
    }
    
    //put every unique first character of the contact name into the sections
    func updateSections(){
        sections.removeAll()
        for item in contacts {
            guard let candidate = item.name.first else{
                continue
            }
            if !sections.contains(candidate){
                sections.append(candidate)
            }
        }
        sections.sort()
    }
    
    func numberOfContactsInSection(sectionNumber: Int) -> Int{
        var answer = 0
        let sectionName = sections[sectionNumber]
        
        for item in contacts{
            let firstChar = item.name.first
            if sectionName == firstChar{
                answer = answer + 1
            }
        }
        return answer
    }
    
    func contactsFromSection(sectionNumber: Int) -> [Contact]{
        var answer = [Contact]()
        let sectionName = sections[sectionNumber]
        
        for item in contacts{
            let firstChar = item.name.first
            if sectionName == firstChar{
                answer.append(item)
            }
        }
        return answer
    }
    
}
