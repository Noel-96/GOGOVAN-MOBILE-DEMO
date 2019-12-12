//
//  ApiController.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 09/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import Foundation
import GooglePlaces
import RxSwift
import RxCocoa



class ApiController {
    
    var locationViewControllerInstance = LocationListViewController()
    
    
    static let instance = ApiController()
 
    let defaultLocationData = [
        autoCompleteRepo(primary_location_name: "Fun Tower", secondary_location_name: "35 Hung To Rd, Kwun Tong"),
        autoCompleteRepo(primary_location_name: "SOGO Causeway Bay", secondary_location_name: "Hennesy Rd Causeway Bay"),
        autoCompleteRepo(primary_location_name: "ifc mall", secondary_location_name: "8 Finance St Central")
    ]
   
    
    
    func getDefaultData() -> Observable<[autoCompleteRepo]>{
        return Observable.create { observer in
            observer.onNext( self.defaultLocationData)
            return Disposables.create()
        }
    }
    
    
    
    func getAutoCompleteLocation(inputText: String , token: GMSAutocompleteSessionToken) -> Observable<[autoCompleteRepo]> {
        
    return Observable.create { observer in
        self.locationViewControllerInstance.placesClient = GMSPlacesClient()
        var listOfLocations = [autoCompleteRepo]()
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        self.locationViewControllerInstance.placesClient?.findAutocompletePredictions(fromQuery: inputText,
        bounds: nil,
        boundsMode: GMSAutocompleteBoundsMode.bias,
        filter: filter,
        sessionToken: token,
        callback: { (results, error) in
        if let error = error {
        debugPrint("Autocomplete error: \(error)")
            observer.onNext(self.defaultLocationData)
        return
        }
        if let results = results {
        for result in results {
        let primaryName = result.attributedPrimaryText.string
        let secondaryName = result.attributedSecondaryText?.string
            let auto_complete_repo = autoCompleteRepo(primary_location_name: primaryName, secondary_location_name: secondaryName ?? ".................")
        listOfLocations.append(auto_complete_repo)
        }
        observer.onNext(listOfLocations)
        }
        })
        return Disposables.create()
    }
    }
    
    
}
