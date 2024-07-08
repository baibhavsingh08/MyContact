//
//  ViewController.swift
//  MyContacts
//
//  Created by Raramuri on 08/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    let contacts =  [
        "John Doe", "Jane Smith", "Michael Johnson", "Emily Brown", "Daniel Wilson",
        "Sarah Martinez", "Kevin Lee", "Amanda Davis", "Jason Taylor", "Rachel Moore",
        "David Harris", "Lisa Clark", "James Lewis", "Jessica Walker", "Christopher Hall",
        "Mary Allen", "Robert Young", "Linda King", "Thomas Wright", "Patricia Scott",
        "Mark Green", "Barbara Adams", "Steven Baker", "Susan Nelson", "Joseph Hill",
        "Karen Ramirez", "Charles Campbell", "Nancy Mitchell", "Paul Roberts", "Betty Carter",
        "Edward Turner", "Margaret Phillips", "Brian Parker", "Sandra Evans", "George Edwards",
        "Ashley Collins", "Ronald Stewart", "Kimberly Sanchez", "Anthony Morris", "Donna Rogers",
        "Kenneth Reed", "Michelle Cook", "Jason Morgan", "Emily Bell", "Eric Murphy",
        "Sophia Bailey", "Ryan Rivera", "Christine Cooper", "Jeffrey Richardson", "Amy Cox",
        "Frank Howard", "Kathleen Ward", "Scott Torres", "Megan Peterson", "Raymond Gray",
        "Laura Ramirez", "Gregory James", "Janet Watson", "Jacob Brooks", "Diane Price",
        "Patrick Bennett", "Angela Wood", "Nicholas Barnes", "Cynthia Ross", "Joshua Henderson",
        "Katherine Coleman", "Gary Jenkins", "Julie Perry", "Andrew Russell", "Victoria Butler",
        "Justin Powell", "Teresa Foster", "Sean Simmons", "Carolyn Gonzales", "Stephen Bryant",
        "Martha Alexander", "Benjamin Russell", "Frances Griffin", "Matthew Shaw", "Ann Knight",
        "Larry Reynolds", "Pamela Fisher", "Timothy Webb", "Debra Kennedy", "Walter Welch",
        "Janice Daniels", "Peter Stevens", "Ruth Wheeler", "Kyle Harper", "Jacqueline Berry",
        "Dennis Warren", "Alice Elliott", "Raymond Fields", "Julia Bishop", "Roger Perry",
        "Gloria Burns", "Jeremy Olson", "Victoria Hart", "Samuel Holland", "Marie Reynolds"
    ]

    
    var sectionTitle = [String]()
    
    var searchContact = [String]()
    
    var namesDict = [String: [String]]()
    
    var searching = false
    
    var finalContacts = [String]()

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        
        
        if(searching == true){
            finalContacts = searchContact
        }else{
            finalContacts = contacts
        }
        
        sectionTitle = Array(Set(finalContacts.compactMap({value in
            String(value.prefix(1))
        })))
        
        sectionTitle.sort()
        
        for secTitle in sectionTitle{
            namesDict[secTitle] = [String]()
        }
        
        for name in finalContacts{
            namesDict[String(name.prefix(1))]?.append(name)
        }
        
//        print(finalContacts)
        print(namesDict)
    }
    

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        print(finalContacts[indexPath.row])
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(identifier: "testVC")
        
        vc.navigationItem.title = namesDict[sectionTitle[indexPath.section]]?[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if(searching == true){
            finalContacts = searchContact
        }else{
            finalContacts = contacts
        }
        
        
        
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
        
        searching = true
        
        finalContacts = searchContact
        
        sectionTitle = Array(Set(finalContacts.compactMap({value in
            String(value.prefix(1))
        })))
        
        sectionTitle.sort()
        
        for secTitle in sectionTitle{
            namesDict[secTitle] = [String]()
        }
        
        for name in finalContacts{
            namesDict[String(name.prefix(1))]?.append(name)
        }
    
        tableView.reloadData()
        
        
    }
}
