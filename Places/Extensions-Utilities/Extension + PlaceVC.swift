//
//  Extension + PlaceVC.swift
//  Places
//
//  Created by Bekzhan on 14.12.2022.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

extension PlacesVC: UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "pin")
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        annotationView.rightCalloutAccessoryView = button
        
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return annotationView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.myCell) as! PlacesTableViewCell
        let place = places[indexPath.row]
        cell.set(place: place)
        
        return cell
    }
    
    //delete with swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteGOT(places[indexPath.row])
            places = loadGOT()
            self.title = "Places"
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.title = places[indexPath.row].title
        self.tableView.tag = 0
        self.tableView.isHidden = true
        messageLabel.isHidden = true
        
        let coor = CLLocationCoordinate2D(
            latitude: places[indexPath.row].latitude,
            longitude: places[indexPath.row].longitude)
        
        let title = places[indexPath.row].title ?? ""
        let subtitle = places[indexPath.row].subtitle ?? ""
        
        render(coor, title, subtitle)
    }
    
    func loadGOT() -> [Location] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
            
            do{
                try places = context.fetch(fetchRequest)
                messageLabel.isHidden = places.isEmpty ? false : true
            }catch{
                print("Hello error! Go away!")
            }
        }
        
        return places
    }
    
    func saveGOT(_ title: String, _ subtitle: String, _ longitude: Double, _ latitude: Double) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            if let entity = NSEntityDescription.entity(forEntityName: "Location", in: context) {
                let place = NSManagedObject(entity: entity, insertInto: context)
                place.setValue(title, forKey: "title")
                place.setValue(subtitle, forKey: "subtitle")
                place.setValue(longitude, forKey: "longitude")
                place.setValue(latitude, forKey: "latitude")
                
                do{
                    try context.save()
                    places.append(place as! Location)
                }catch{
                    print("Warning! Error is here!")
                }
            }
        }
    }
    
    func deleteGOT(_ object: Location) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(object)
            do{
                try context.save()
            } catch {
                
            }
        }
    }
}

