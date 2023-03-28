//
//  PlacesVC.swift
//  Places
//
//  Created by Bekzhan on 08.12.2022.
//

import UIKit
import MapKit
import CoreData
import CoreLocation


class PlacesVC: UIViewController, CLLocationManagerDelegate{
    
    struct Cells {
        static let myCell = "myCell"
    }
    
    let mapView = MKMapView()
    let messageLabel = UILabel()
    
    var tableView = UITableView()
    var places: [Location] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = loadGOT()
        
        setupViews()
        configureMapView()
        configureTableView()
        configureMessageLabel()
        createSuitSegmentedControl()
        
        setupTapGesture()
    }
    
    private func setupViews() {
        title = "Places"
        createCustomNavigationBar()
        
        let folderRightButton = createCustomBarButton(
            imageName: "folder",
            selector: #selector(folderRightButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = folderRightButton
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.pin(to: view)
        mapView.delegate = self
    }
    
    
    //TableView
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 80
        tableView.register(PlacesTableViewCell.self, forCellReuseIdentifier: Cells.myCell)
        tableView.pin(to: view)
        tableView.isHidden = true
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //Tap gestures
    func setupTapGesture() {
        let longPressTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        
        mapView.addGestureRecognizer(longPressTapGesture)
    }
    
    @objc func longPressed(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        print("Long Pressed")
        
        let alert = UIAlertController(title: "Add Place", message: "Fill all the fields", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .default)
        { [self] (UIAlertAction) in
            
            let title = alert.textFields?[0].text ?? ""
            let subtitle = alert.textFields?[1].text ?? ""
            
            let latitude: Double = coordinate.latitude
            let longitude: Double = coordinate.longitude
            
            saveGOT(title, subtitle, longitude, latitude)
            render(coordinate, title, subtitle)
            self.title = title
            tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter title"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter subtitle"
        }
        
        alert.addAction(saveAction)
    
        present(alert, animated: true, completion: nil)
    }
    
    
    func configureMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.text = "No places"
        messageLabel.isHidden = true
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    
    @objc private func folderRightButtonTapped() {
        print("folderRightButtonTapped")
        
        if tableView.tag == 0 {
            tableView.tag = 1
            tableView.isHidden = false
            messageLabel.isHidden = places.isEmpty ? false : true
        } else if tableView.tag == 1 {
            tableView.tag = 0
            tableView.isHidden = true
            messageLabel.isHidden = true
        }
    }
    
    
    //Segment Control
    func createSuitSegmentedControl() {
        let items = ["Standard", "Satellite", "Hybrid"]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(suitDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
        ])
    }
    
    @objc func suitDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .satellite
        case 2: mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    
    @objc func infoButtonTapped() {
        print("info")
        let editVC = EditVC()
        
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    
    func render(_ coordinate: CLLocationCoordinate2D, _ title: String, _ subtitle: String) {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let pin = MKPointAnnotation()
        pin.title = title
        pin.subtitle = subtitle
        pin.coordinate = coordinate
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(pin)
    }
}

