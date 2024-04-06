//
//  ThirdViewController.swift
//  CoreData3
//
//  Created by ABDULLAH GÜNAN on 6.04.2024.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var ChosenName = ""
    var ChosenId : UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printData()
        
    }
    
    func printData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Gallery")
        let stringUUID = ChosenId?.uuidString
        if stringUUID != "" {
            fetchRequest.predicate = NSPredicate(format: "id = %@", stringUUID!)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String{
                        nameLabel.text! = name
                    }
                    if let imageData = result.value(forKey: "image") as? Data {
                       let image = UIImage(data: imageData)
                        imageView2.image = image
                    }
                }
            }catch{
                printContent("error")
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
