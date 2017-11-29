import UIKit

class HistoryTVC: UITableViewController {

    var history = [HistoryUnit]()
    var sections = [String]()
    
    let day: Double = 1000 * 60 * 60 * 24
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let noname = Contact(name: "NoName", phone: "xxx")
        history.append(HistoryUnit(date: Date(timeIntervalSinceNow: day + 53765), contact: noname))
        history.append(HistoryUnit(date: Date(timeIntervalSinceNow: 2 * day + 856345), contact: noname))
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        updateSections()
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfHistoryUnitsInSection(sectionNumber: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let currentItem = historyFromSection(sectionNumber: indexPath.section)[indexPath.row]
        let detailesFormatter = DateFormatter()
        detailesFormatter.locale = Locale(identifier: "en_US")
        detailesFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        cell.textLabel?.text = currentItem.contact.name
        cell.detailTextLabel?.text = detailesFormatter.string(from: currentItem.date)

        return cell
    }
 
    //put every unique call date into the sections
    func updateSections(){
        sections.removeAll()
        for item in history {
            let candidate = formatter.string(from: item.date)
            if !sections.contains(candidate){
                sections.append(candidate)
            }
        }
        sections.sort()
    }
    
    func numberOfHistoryUnitsInSection(sectionNumber: Int) -> Int{
        var answer = 0
        let sectionName = sections[sectionNumber]

        for item in history{
            let candidate = formatter.string(from: item.date)
            if sectionName == candidate{
                answer = answer + 1
            }
        }
        return answer
    }
    
    func historyFromSection(sectionNumber: Int) -> [HistoryUnit]{
        var answer = [HistoryUnit]()
        let sectionName = sections[sectionNumber]
        
        for item in history{
            let candidate = formatter.string(from: item.date)
            if sectionName == candidate{
                answer.append(item)
            }
        }
        return answer
    }
}
