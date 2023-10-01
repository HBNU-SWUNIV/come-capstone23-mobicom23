//
//  MapViewController.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/4/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var noticeImage: UIImageView!
    
    var check = false
    var locationManager = CLLocationManager()
    var userMarkers: [CustomAnnotation] = []
    var allMarkers: [CustomAnnotation] = []
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        // 정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터를 추적하기 위해 사용자에게 승인 요구
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트를 시작
        locationManager.startUpdatingLocation()
        // 위치 보기 설정
        mapView.showsUserLocation = true
        sendGetRequest(email: GlobalVariable.shared.userEmail!)
        
//        let marker1Coordinate = CLLocationCoordinate2D(latitude: 36.3526616, longitude: 127.298719)
//        let marker1 = CustomAnnotation(title: "난폭운전 종류: 차간주행", subtitle: "2023-08-05 11:47", coordinate: marker1Coordinate)
//        markers.append(marker1)
//        
//        let marker2Coordinate = CLLocationCoordinate2D(latitude: 36.3547360, longitude: 127.298575)
//        let marker2 = CustomAnnotation(title: "난폭운전 종류: 와리가리", subtitle: "2023-08-21 17:56", coordinate: marker2Coordinate)
//        markers.append(marker2)
    }
    
    func sendGetRequest(email: String) {
//        guard let url = URL(string: "http://121.159.178.99:8080/getData/\(email)") else {
        guard let url = URL(string: "http://172.17.47.4:8080/getData/\(email)") else {
            print("URL 생성에 실패했습니다.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("요청 실패: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print(jsonArray)
                        for jsonObject in jsonArray {
                            let latitude = jsonObject["latitude"] as? Double
                            let longitude = jsonObject["longitude"] as? Double
                            let time = jsonObject["time"] as? String
                            if let type = jsonObject["type"] as? String {
                                let markerCoordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                                self.userMarkers.append(CustomAnnotation(title: type, subtitle: time, coordinate: markerCoordinate))
                            }
                        }
                        self.mapView.addAnnotations(self.userMarkers)
                    }
//                    let decoder = JSONDecoder()
//                    let myData = try? JSONDecoder().decode(LocationData.self, from: data)
//                    print(myData)
//                    print("원하는 값: \(myData?.time)")
                } catch {
                    print("JSON 파싱 실패: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }
    
    func sendGetAllDataRequest(email: String) {
//        guard let url = URL(string: "http://121.159.178.99:8080/getData/\(email)") else {
        guard let url = URL(string: "http://172.17.47.4:8080/data/list") else {
            print("URL 생성에 실패했습니다.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("요청 실패: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print(jsonArray)
                        for jsonObject in jsonArray {
                            let latitude = jsonObject["latitude"] as? Double
                            let longitude = jsonObject["longitude"] as? Double
                            let time = jsonObject["time"] as? String
                            if let type = jsonObject["type"] as? String {
                                let markerCoordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                                self.allMarkers.append(CustomAnnotation(title: type, subtitle: time, coordinate: markerCoordinate))
                            }
                        }
                    }
//                    let decoder = JSONDecoder()
//                    let myData = try? JSONDecoder().decode(LocationData.self, from: data)
//                    print(myData)
//                    print("원하는 값: \(myData?.time)")
                } catch {
                    print("JSON 파싱 실패: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            currentLocation = newLocation
            
            var dangerousCount = 0
            for marker in allMarkers {
                if let location = currentLocation {
                    let markerLocation = CLLocation(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
                    let distance = location.distance(from: markerLocation)
                    check = false
                    
                    if distance <= 100 {
                        dangerousCount += 1
                    }
                    
                    if dangerousCount >= 3 {
                        // Trigger a notification
                        let notification = UNMutableNotificationContent()
                        notification.title = "Marker Proximity"
                        notification.body = "You are within 500m of \(marker.title ?? "a marker")!"
                        
                        let request = UNNotificationRequest(identifier: "markerProximity", content: notification, trigger: nil)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        noticeImage.image = UIImage(named: "dangerous.png")
                        check = true
                    } else if check == false {
                        noticeImage.image = UIImage(named: "safe.png")
                    }
                }
            }
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Implement custom annotation view if needed
        return nil
    }
}

// Custom annotation class
class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

struct LocationData: Codable {
    let id: Int?
    let email: String?
    let latitude: Double?
    let longitude: Double?
    let type: String?
    let time: String?
    // 다른 키에 대한 속성 추가 가능
}
