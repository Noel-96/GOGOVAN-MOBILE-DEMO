//
//  autoCompleteRepo.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 09/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import Foundation
import UIKit


class autoCompleteRepo {
    public private(set) var primary_location_name: String
    public private(set) var secondary_location_name: String
    
    init( primary_location_name: String, secondary_location_name: String) {
        self.primary_location_name = primary_location_name
        self.secondary_location_name = secondary_location_name
    }
    
}
