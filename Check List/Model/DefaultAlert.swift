//
//  DefaultAlert.swift
//  Check List
//
//  Created by Роман Важник on 17/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

class DefaultAlert {
    
    static func createDefaultAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
