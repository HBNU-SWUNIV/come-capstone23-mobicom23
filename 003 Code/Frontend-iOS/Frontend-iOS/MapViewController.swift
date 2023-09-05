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
    @IBOutlet weak var notice: UILabel!
    @IBOutlet weak var locationInfo1: UILabel!
    @IBOutlet weak var locationInfo2: UILabel!
    
    var check = false
    var locationManager = CLLocationManager()
    var markers: [CustomAnnotation] = []
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        locationInfo1.text = ""
//        locationInfo2.text = ""
        locationManager.delegate = self
        // 정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터를 추적하기 위해 사용자에게 승인 요구
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트를 시작
        locationManager.startUpdatingLocation()
        // 위치 보기 설정
        mapView.showsUserLocation = true
        
        let marker1Coordinate = CLLocationCoordinate2D(latitude: 36.3526616, longitude: 127.298719)
        let marker1 = CustomAnnotation(title: "Marker 1", subtitle: "Marker 1 Subtitle", coordinate: marker1Coordinate)
        markers.append(marker1)
        
        let marker2Coordinate = CLLocationCoordinate2D(latitude: 36.3547360, longitude: 127.298575)
        let marker2 = CustomAnnotation(title: "Marker 2", subtitle: "Marker 2 Subtitle", coordinate: marker2Coordinate)
        markers.append(marker2)
        
        mapView.addAnnotations(markers)
    }
    
//    // 위도와 경도, 스팬(영역 폭)을 입력받아 지도에 표시
//    func goLocation(latitudeValue: CLLocationDegrees,
//                    longtudeValue: CLLocationDegrees,
//                    delta span: Double) -> CLLocationCoordinate2D {
//        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
//        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
//        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
//        mapView.setRegion(pRegion, animated: true)
//        return pLocation
//    }
    
//    // 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
//    func setAnnotation(latitudeValue: CLLocationDegrees,
//                       longitudeValue: CLLocationDegrees,
//                       delta span :Double,
//                       title strTitle: String,
//                       subtitle strSubTitle:String){
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
//        annotation.title = strTitle
//        annotation.subtitle = strSubTitle
//        mapView.addAnnotation(annotation)
//    }
    
    // 위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let pLocation = locations.last
//        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!,
//                   longtudeValue: (pLocation?.coordinate.longitude)!,
//                   delta: 0.01)
//        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {(placemarks, error) -> Void in
//            let pm = placemarks!.first
//            let country = pm!.country
//            var address: String = ""
//            if country != nil {
//                address = country!
//            }
//            if pm!.locality != nil {
//                address += " "
//                address += pm!.locality!
//            }
//            if pm!.thoroughfare != nil {
//                address += " "
//                address += pm!.thoroughfare!
//            }
////            self.locationInfo1.text = "현재 위치"
////            self.locationInfo2.text = address
//        })
//        locationManager.stopUpdatingLocation()
//    }
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            currentLocation = newLocation
            
            for marker in markers {
                if let location = currentLocation {
                    let markerLocation = CLLocation(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
                    let distance = location.distance(from: markerLocation)
                    check = false
                    
                    if distance <= 100 {
                        // Trigger a notification
                        let notification = UNMutableNotificationContent()
                        notification.title = "Marker Proximity"
                        notification.body = "You are within 500m of \(marker.title ?? "a marker")!"
                        
                        let request = UNNotificationRequest(identifier: "markerProximity", content: notification, trigger: nil)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        notice.text = "경고"
                        check = true
                    } else if check == false {
                        notice.text = "안전"
                    }
                }
            }
        }
    }
    
//    // 세크먼트 컨트롤을 선택하였을 때 호출
//    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            // "현재 위치" 선택 - 현재 위치 표시
//            self.locationInfo1.text = ""
//            self.locationInfo2.text = ""
//            locationManager.startUpdatingLocation()
//        } else if sender.selectedSegmentIndex == 1 {
//            // "물왕저수지 정통밥집" 선택 - 핀을 설치하고 위치 정보 표시
//            setAnnotation(latitudeValue: 37.3826616, longitudeValue: 126.840719, delta: 0.1, title: "물왕저수지 정통밥집", subtitle: "경기 시흥시 동서로857번길 6")
//            self.locationInfo1.text = "보고 계신 위치"
//            self.locationInfo2.text = "물왕저수지 정통밥집"
//        } else if sender.selectedSegmentIndex == 2 {
//            // "이디야 북한산점" 선택 - 핀을 설치하고 위치 정보 표시
//            setAnnotation(latitudeValue: 37.6447360, longitudeValue: 127.005575, delta: 0.1, title: "이디야 북한산점", subtitle: "서울 강북구 4.19로 85")
//                       self.locationInfo1.text = "보고 계신 위치"
//                       self.locationInfo2.text = "이디야 북한산점"
//        }
//
//    }
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
