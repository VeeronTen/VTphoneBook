import UIKit

class ContactsTVC: UITableViewController {

    var contacts = [Contact]()
    var sections = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts.append(Contact(name: "av", phone: "ss"))
        contacts.append(Contact(name: "ss", phone: "ss"))
        contacts.append(Contact(name: "bb", phone: "ss"))
        contacts.append(Contact(name: "s3", phone: "ss"))
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
