//
//  MapViewController.swift
//  Assignment3
//
//  Created by  Nikita Paralkar on 2019-11-12.
//  Copyright © 2019 Matthew Marini. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 43.4684, longitude: -79.6991)
    var passedLocation : String = ""
    
    @IBOutlet var myMapView : MKMapView!
    @IBOutlet var txtLocEntered : UITextField!
    @IBOutlet var myTableView : UITableView!
    
    @IBAction func addLocation(sender : Any){
        let location : Data = Data.init()
        location.initWithData(theRow: 0, theLoc: txtLocEntered.text!)
       
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        let returnCode = mainDelegate.insertIntoDatabase(location: location)
        
        var returnMsg : String = "Location was saved successfully"
        
        if !returnCode {
            returnMsg = "Location could not be saved"
        }
        
        let alertController = UIAlertController(title: "Save Location", message: returnMsg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    func savedWasSelected(data: String){
        txtLocEntered.text = data
        findNewLocation()
    }
    
    var routeSteps = ["Enter a destination to see the steps"]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    let regionRadius : CLLocationDistance = 1000
    func centerMapOnLocation(location : CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        myMapView.setRegion(coordinateRegion, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        centerMapOnLocation(location: initialLocation)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = initialLocation.coordinate
        dropPin.title = "Starting at Sheridan College - Trafalgar Campus"
        
        let davisPin = MKPointAnnotation()
        davisPin.coordinate = CLLocation(latitude: 43.65536, longitude: -79.73817).coordinate
        davisPin.title = "Sheridan College - Davis Campus"
        
        let oakGOPin = MKPointAnnotation()
        oakGOPin.coordinate = CLLocation(latitude: 43.4555, longitude: -79.6835).coordinate
        oakGOPin.title = "Oakville GO"
        
        let unionGOPin = MKPointAnnotation()
        unionGOPin.coordinate = CLLocation(latitude: 43.6453, longitude: -79.3806).coordinate
        unionGOPin.title = "Union GO"
        
        self.myMapView.addAnnotation(oakGOPin)
        self.myMapView.addAnnotation(dropPin)
        self.myMapView.addAnnotation(davisPin)
        self.myMapView.addAnnotation(unionGOPin)
        self.myMapView.selectAnnotation(dropPin, animated: true)
    }
    
    @IBAction func unwindToMapViewController(sender: UIStoryboardSegue){
        if let pickerViewController = sender.source as? PickerViewController {
            passedLocation = pickerViewController.passedLocation!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtLocEntered.text = passedLocation
        findNewLocation()
    }
    
    @IBAction func findNewLocation(){
        let locEnteredText = txtLocEntered.text
        let geocoder = CLGeocoder()
        self.myMapView.removeOverlays(self.myMapView.overlays)
        geocoder.geocodeAddressString(locEnteredText!, completionHandler:
            {(placemarks, error) -> Void in
                if (error != nil){
                    print("Error", error!)
                }
                if let placemark = placemarks?.first{
                    let coordinates : CLLocationCoordinate2D = placemark.location!.coordinate
                    let newLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    self.centerMapOnLocation(location: newLocation)
                    
                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = coordinates
                    dropPin.title = placemark.name
                    self.myMapView.addAnnotation(dropPin)
                    self.myMapView.selectAnnotation(dropPin, animated: true)
                    
                    let request = MKDirections.Request()
                    request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.initialLocation.coordinate, addressDictionary: nil))
                    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary: nil))
                    
                    request.requestsAlternateRoutes = false
                    request.transportType = .any
                    
                    let directions = MKDirections(request: request)
                    directions.calculate(completionHandler:
                        {
                            [unowned self] response, error in
                            
                            for route in (response?.routes)!{
                                self.myMapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                                self.myMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                                self.routeSteps.removeAll()
                                for step in route.steps {
                                    self.routeSteps.append(step.instructions)
                                }
                                self.myTableView.reloadData()
                                
                                
                            }
                            
                    })
                }
                
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeSteps.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        tableCell.textLabel?.text = routeSteps[indexPath.row]
        
        return tableCell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
