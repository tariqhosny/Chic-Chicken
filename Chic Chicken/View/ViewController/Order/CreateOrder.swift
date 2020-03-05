//
//  CreateOrder.swift
//  Chic Chicken
//
//  Created by Tariq on 11/19/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CoreLocation
import MapKit

class CreateOrder: UIViewController, NVActivityIndicatorViewable, CLLocationManagerDelegate {

    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var countryTf: UITextField!
    @IBOutlet weak var cityTf: UITextField!
    @IBOutlet weak var regionTf: UITextField!
    @IBOutlet weak var streetTf: UITextField!
    @IBOutlet weak var buildNumTf: UITextField!
    @IBOutlet weak var floorNumTf: UITextField!
    
    var price = String()
    var userLat = 0.0
    var userLng = 0.0
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        locationManager.delegate = self
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("error")
                return
            }
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0] as CLPlacemark?
                let address = (pm?.thoroughfare)! + " " + (pm?.locality)! + " " + (pm?.country)!
                self.regionTf.text = ("\(pm?.subLocality ?? "")")
                self.cityTf.text = "\(pm?.administrativeArea ?? "")"
                self.countryTf.text = "\(pm?.country ?? "")"
                self.streetTf.text = "\(pm?.subThoroughfare ?? "") \(pm?.thoroughfare ?? "")"
                print("addersssss \(address)")
                self.stopAnimating()
            }else {
                print("error2")
                self.stopAnimating()
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        userLat = locValue.latitude
        userLng = locValue.longitude
        convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func getMyLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func getMyLocationBtn(_ sender: UIButton) {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        getMyLocation()
    }
    
    @IBAction func checkOutPressed(_ sender: UIButton) {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            let messages = "Please enter your Phone Number"
            self.showAlert(title: "Order", message: messages)
            return
        }
        guard let country = countryTf.text, !country.isEmpty else {
            let messages = "Please enter your country"
            self.showAlert(title: "Order", message: messages)
            return
        }
        guard let city = cityTf.text, !city.isEmpty else {
            let messages = "Please enter your city"
            self.showAlert(title: "Order", message: messages)
            return
        }
        guard let region = regionTf.text, !region.isEmpty else {
            let messages = "Please enter your region"
            self.showAlert(title: "Order", message: messages)
            return
        }
        guard let street = streetTf.text, !street.isEmpty else {
            let messages = "Please enter your street"
            self.showAlert(title: "Order", message: messages)
            return
        }
        guard let buildNum = buildNumTf.text, !buildNum.isEmpty else {
            let messages = "Please enter your build number"
            self.showAlert(title: "Order", message: messages)
            return
        }
        guard let floorNum = floorNumTf.text, !floorNum.isEmpty else {
            let messages = "Please enter your floor Number"
            self.showAlert(title: "Order", message: messages)
            return
        }
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        OrderApis.createOrderApi(price: price, phone: phone, paymentMethod: 1, paymentStatus: 1, city: city, country: country, street: street, floorNumber: floorNum, homeNumber: buildNum, region: region, lat: userLat, long: userLng) { (dataError, isSuccess, message) in
            if dataError!{
                print("data error")
                self.stopAnimating()
            }else{
                if isSuccess!{
                    if let message = message?.data{
                        let alert = UIAlertController(title: "Order", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action: UIAlertAction) in
                            helper.restartApp()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.stopAnimating()
                }else{
                    self.showAlert(title: "Connection", message: "Please check your internet connection")
                    self.stopAnimating()
                }
            }
        }
    }
    
}
