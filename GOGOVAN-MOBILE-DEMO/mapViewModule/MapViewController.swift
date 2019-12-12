//
//  ViewController.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 03/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, UITextFieldDelegate ,UIViewControllerTransitioningDelegate{
    
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pickUpTxtField: RoundedCornerTextField!
    @IBOutlet weak var dropOffTxtField: RoundedCornerTextField!
    @IBOutlet weak var bottomUiView: UIView!
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickUpTxtField.delegate = self
        dropOffTxtField.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let location_list = storyboard!.instantiateViewController(withIdentifier: "LocationListViewController") as! LocationListViewController
        location_list.transitioningDelegate = self
        present(location_list, animated: true, completion: nil)
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
         transition.originFrame = bottomUiView!.superview!.convert(bottomUiView!.frame, to: nil)
         bottomUiView?.isHidden = true
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
         return transition
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}
