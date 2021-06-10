//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Maksym Levytskyi on 07.06.2021.
//

import UIKit
import CoreLocation

class TaskCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var dateFormatter: DateFormatter{
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    func configure(withTask task: Task, done: Bool = false ){
        
        
        if done{
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            
            self.titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
            
        } else {
            let stringDate = dateFormatter.string(from: task.date)
            dateLabel.text = stringDate
            
            self.titleLabel.text = task.title
            self.locationLabel.text = task.location?.name
        }
    }
    
}
