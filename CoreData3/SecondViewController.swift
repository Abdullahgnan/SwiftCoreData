//
//  SecondViewController.swift
//  CoreData3
//
//  Created by ABDULLAH GÜNAN on 5.04.2024.
//

import UIKit
import CoreData

class SecondViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate {
    var nameArray = [String]()
    var idArray = [UUID]()
    var SelectedName = ""
    var SelectedId : UUID?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = nameArray[indexPath.row]
        cell.contentConfiguration = context
        return cell
        
    }
        

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
        
    }
    @objc func getData() {
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelete = UIApplication.shared.delegate as! AppDelegate
        let context = appDelete.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Gallery")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name"){
                    nameArray.append(name as! String)
                }
                if let id = result.value(forKey: "id"){
                    idArray.append(id as! UUID)
                }

            }
        } catch {
            print("error")
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SelectedId = idArray[indexPath.row]
        performSegue(withIdentifier: "toThirdVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC"{
            let destinationVC = segue.destination as? ThirdViewController
            destinationVC?.ChosenId=SelectedId
        }
    }
    
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toView", sender: nil)
        
    }
}
