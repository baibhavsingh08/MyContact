//
//  ViewController.swift
//  MyContacts
//
//  Created by Raramuri on 08/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    let contacts =  [
        "John Doe",
        "Jane Smith",
        "Michael Johnson",
        "Emily Brown",
        "Daniel Wilson",
        "Sarah Martinez",
        "Kevin Lee",
        "Amanda Davis",
        "Jason Taylor",
        "Rachel Moore"
    ]
    
    var sectionTitle = [String]()
    
    var namesDict = [String: [String]]()
    
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        sectionTitle = Array(Set(contacts.compactMap({value in
            String(value.prefix(1))
        })))
        
        sectionTitle.sort()
        
        for secTitle in sectionTitle{
            namesDict[secTitle] = [String]()
        }
        
        for name in contacts{
            namesDict[String(name.prefix(1))]?.append(name)
        }
    }
    

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        print(contacts[indexPath.row])
    }
}

extension ViewController: UITableViewDataSource{
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
