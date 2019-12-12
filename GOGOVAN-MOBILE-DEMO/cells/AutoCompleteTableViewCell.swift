//
//  AutoCompleteTableViewCell.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 09/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import UIKit

class AutoCompleteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationPrimaryName: UILabel!
    @IBOutlet weak var locationSecondaryName: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    
    
    func configureCell(repo: autoCompleteRepo) {
        locationPrimaryName.text = repo.primary_location_name
        locationSecondaryName.text = repo.secondary_location_name
        locationImage.image = UIImage(named: "locationsIcon")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
