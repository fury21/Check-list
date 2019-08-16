//
//  Extension String.swift
//  Check List
//
//  Created by Viktor on 15/08/2019.
//  Copyright © 2019 Александр Б. All rights reserved.
//

import UIKit

extension String {
    
    // Механизм найденный в сети, зачеркивает строку по схеме: "Тест".strikeThrough()
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 1,
            range: NSRange(location: 0, length: attributeString.length))
        
        return attributeString
    }
}
