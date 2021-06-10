//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Maksym Levytskyi on 08.06.2021.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController{
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var adressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cnacelButton: UIButton!
    
    @IBAction func save(){
        let titleString = titleTextField.text
        let locationString = locationTextField.text
        let date = dateFormatter.date(from: dateTextField.text!)
        let adressString = adressTextField.text
        let descriptionString = descriptionTextField.text
        
        geocoder.geocodeAddressString(adressString!) {[unowned self] (placemarks, error) in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString!, coordinate: coordinate)
            let task = Task(title: titleString!, description: descriptionString, date: date, location: location)
            self.taskManager.addTask(task: task)
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    var dateFormatter: DateFormatter{
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
}
