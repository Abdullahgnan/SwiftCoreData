//
//  ViewController.swift
//  CoreData3
//
//  Created by ABDULLAH GÜNAN on 3.04.2024.
//

import UIKit
import CoreData

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled=true
        let reco = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        imageView.addGestureRecognizer(reco)
        // Do any additional setup after loading the view.
    }
    @objc func tapImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveClick(_ sender: Any) {
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegete.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "Gallery", into: context)
        saveData.setValue(nameField.text, forKey: "name")
        let imagePress = imageView.image?.jpegData(compressionQuality: 0.5)
        saveData.setValue(imagePress, forKey: "image")
        saveData.setValue(UUID(), forKey: "id")
        do {
            try context.save()
            print("succes")
        } catch {
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)

        navigationController?.popViewController(animated: true)
        

    }
    
}

