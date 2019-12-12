//
//  LocationListViewController.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 04/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import UIKit
import GooglePlaces
import RxCocoa
import RxSwift

class LocationListViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate{

    @IBOutlet weak var backButtonImageVieew: UIImageView!
    @IBOutlet weak var pickUpTxtField: RoundedCornerTextField!
    @IBOutlet weak var dropOffTxtField: RoundedCornerTextField!
    @IBOutlet weak var autoCompleteTableView: UITableView!
    
    var placesClient : GMSPlacesClient?
    var disposeBag = DisposeBag()
    var activeTextField = UITextField()
    
    
    override func viewWillAppear(_ animated: Bool) {
     backButtonImageVieew.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
     pickUpTxtField.delegate = self
     dropOffTxtField.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoCompleteTableView.tableFooterView = UIView()
        let token = GMSAutocompleteSessionToken.init()
        bindElements(token: token)
        autoCompleteTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
 
    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    
    func bindElements(token: GMSAutocompleteSessionToken) {
        
         let textField1Text = pickUpTxtField.rx.text
         let textField2Text = dropOffTxtField.rx.text
        
        let searchResultsObservable = Observable.of(textField1Text, textField2Text)
            .merge()
            .debounce(2, scheduler: MainScheduler.instance)
            .map { $0?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "" }
            .flatMapLatest{  query -> Observable<[autoCompleteRepo]> in
                if query.isEmpty {
                    return ApiController.instance.getDefaultData()
                }
                return ApiController.instance.getAutoCompleteLocation(inputText: query, token: token)
        }
            .observeOn(MainScheduler.instance)
        
        
        searchResultsObservable.bind(to: autoCompleteTableView.rx.items(cellIdentifier: "searchCell")){ (row, repo: autoCompleteRepo, cell: AutoCompleteTableViewCell) in
            cell.configureCell(repo: repo)
        }
            .disposed(by: disposeBag)
    }
    
}



extension LocationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        guard let cell = tableView.cellForRow(at: indexPath) as? AutoCompleteTableViewCell else { return }


        if  dropOffTxtField == self.activeTextField {
            dropOffTxtField.text =  "\(cell.locationPrimaryName?.text ?? " ") \(cell.locationSecondaryName?.text ?? " ")"
            return
        } else if  pickUpTxtField == self.activeTextField {
            pickUpTxtField.text = "\(cell.locationPrimaryName?.text ?? " ") \(cell.locationSecondaryName?.text ?? " ")"
            return
        } 
    }
    
}
