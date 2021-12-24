//
//  UIButton_Extension.swift
//  Task
//
//  Created by Victor Mendes on 23/12/21.
//

import UIKit

extension UIButton {
    var customButtonAddTask: UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.frame = CGRect(x: 290, y: 720, width: 70, height: 70)
        button.tintColor = .white
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.8
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .large)
        if let largePlus = UIImage(systemName: "plus", withConfiguration: largeConfig) {
            button.setImage(largePlus, for: .normal)
        }
        return button
    }
}
