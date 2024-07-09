import UIKit

class ViewController: UIViewController {
    var contacts = [String]()
    var sectionTitle = [String]()
    var searchContact = [String]()
    var namesDict = [String: [String]]()
    var finalContacts = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        readJSON()
        
        finalContacts = contacts

        sectionTitle = Array(Set(finalContacts.compactMap({value in
            String(value.prefix(1))
        })))
        
        sectionTitle.sort()
        
        for secTitle in sectionTitle {
            namesDict[secTitle] = [String]()
        }
        
        for name in finalContacts {
            namesDict[String(name.prefix(1))]?.append(name)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC")
        vc.navigationItem.title = namesDict[sectionTitle[indexPath.section]]?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  namesDict[sectionTitle[indexPath.section]]?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchContact = contacts.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        finalContacts = searchContact
        
        sectionTitle = Array(Set(finalContacts.compactMap({value in
            String(value.prefix(1))
        })))
        
        sectionTitle.sort()
        
        for secTitle in sectionTitle {
            namesDict[secTitle] = [String]()
        }
        
        for name in finalContacts {
            namesDict[String(name.prefix(1))]?.append(name)
        }
        
        tableView.reloadData()
    }
    
    func readJSON() {
        if let path = Bundle.main.path(forResource: "Name", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
                let name = try JSONDecoder().decode([String].self, from: data)
                
                for item in name {
                    contacts.append(item)
                }
            }catch {
                print("Something wrong")
            }
        }else {
            print("wrong name")
        }
    }
}
