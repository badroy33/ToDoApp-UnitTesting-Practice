//
//  String+extension.swift
//  ToDoApp
//
//  Created by Maksym Levytskyi on 09.06.2021.
//

import UIKit

extension String{
    var percentEncoded: String{
        let allowedCharacters = CharacterSet(charactersIn: "±!@#$%^&*()-+=[]\\}{,./?><").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        return encodedString
    }
}
