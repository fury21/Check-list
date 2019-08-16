//
//  Extension UIViewController.swift
//  Check List
//
//  Created by Viktor on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Создал вункции ку да передаем Lable и получаем Lable с зачеркнутым текстом
    
    public func strikeThroughText(label: UILabel) -> UILabel {
        label.attributedText = label.text?.strikeThrough()
        
        return label
    }
}

