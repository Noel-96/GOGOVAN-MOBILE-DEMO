//
//  RoundedCornerTextField.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 09/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.8
        layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        layer.cornerRadius = self.frame.height/2
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
