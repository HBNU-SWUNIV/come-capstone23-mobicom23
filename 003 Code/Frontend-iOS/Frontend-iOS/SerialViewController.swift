//
//  SerialViewController.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/4/23.
//

import UIKit
import CoreLocation



class SerialViewController: UIViewController, BluetoothSerialDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var serialMessageLabel1: UILabel!
    @IBOutlet weak var serialMessageLabel2: UILabel!
    @IBOutlet weak var serialMessageLabel3: UILabel!
    
    @IBOutlet weak var driveModeLabel: UILabel!
    @IBOutlet weak var driveModeImageView: UIImageView!
    
    @IBOutlet weak var dangerousBetweenDriveCount: UILabel!
    @IBOutlet weak var dangerousBetweenDriveLabel: UILabel!
    
    @IBOutlet weak var dangerousWarigariDriveCount: UILabel!
    @IBOutlet weak var dangerousWarigariDriveLabel: UILabel!
    
    var locationManger = CLLocationManager()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var dangerousBetweenCount = 0
    var dangerousBetweenDrive = 0
    
    var dangerousWarigariCount = 0
    var dangerousWarigariDrive = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 델리게이트 설정
        locationManger.delegate = self
        // 거리 정확도 설정
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        // 사용자에게 허용 받기 alert 띄우기
        locationManger.requestWhenInUseAuthorization()
  
        // 아이폰 설정에서의 위치 서비스가 켜진 상태라면
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("위치 서비스 On 상태")
         locationManger.startUpdatingLocation() //위치 정보 받아오기 시작
            print(locationManger.location?.coordinate as Any)
        } else {
            print("위치 서비스 Off 상태")
        }
        
        // BluetoothSerial.swift 파일에 있는 Bluetooth Serial인 serial을 초기화합니다.
        serial = BluetoothSerial.init()
        // GET 요청 보내기
        sendGetRequest()
        print("hi")
    }
    
    /// scan 버튼이 클릭되면 호출되는 메서드입니다.
    @IBAction func scanButton(_ sender: UIButton) {
        // 세그웨이를 호출하여 Scan 뷰를 로드합니다.
//        performSegue(withIdentifier: "ScanViewController", sender: nil)
        let vcScan = self.storyboard?.instantiateViewController(withIdentifier: "ScanViewController")
        self.navigationController?.pushViewController(vcScan!, animated: true)
    }
    
    /// 주변기기에 데이터를 전송합니다.
    @IBAction func onButton(_ sender: UIButton) {
        if !serial.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        // 시리얼의 delegate를 SerialViewController로 설정합니다.
        serial.delegate = self
        // msg를 설정하고 이를 연결된 Peripheral에 전송하는 메서드를 호출합니다.
        let msg = "1"
        serial.sendMessageToDevice(msg)
        // 라벨의 텍스트를 변경하여 데이터를 기다리는 중이라는 것을 표현합니다.
        serialMessageLabel1.text = "wait"
        serialMessageLabel2.text = "wait"
        serialMessageLabel3.text = "wait"
        
        serialMessageLabel1.textColor = UIColor.black
        serialMessageLabel2.textColor = UIColor.black
        serialMessageLabel3.textColor = UIColor.black
        dangerousBetweenDriveCount.textColor = UIColor.black
        dangerousBetweenDriveLabel.textColor = UIColor.black
        dangerousWarigariDriveCount.textColor = UIColor.black
        dangerousWarigariDriveLabel.textColor = UIColor.black
        driveModeLabel.textColor = UIColor.black
    }
    
    //MARK: 시리얼에서 호출되는 Delegate 함수들
    
    /// 데이터가 전송된 후 Peripheral로 부터 응답이 오면 호출되는 메서드입니다.
    func serialDidReceiveMessage(message : String)
    {
        let arr = message.components(separatedBy: "&")
        let leftDis = arr[0]
        let rightDis = arr[1]
        let ang = String(arr[2].dropLast())
        
        driveModeLabel.text = "안전 주행중"
        driveModeImageView.image = UIImage(named: "BikeBasic.png")
        
        serialMessageLabel1.textColor = UIColor.black
        serialMessageLabel2.textColor = UIColor.black
        serialMessageLabel3.textColor = UIColor.black
        
        
        if Int(leftDis)! <= 400 || Int(rightDis)! <= 400 {
            driveModeLabel.text = "차간 주행중!"
            driveModeImageView.image = UIImage(named: "BikeBasic.png")
            
            if Int(leftDis)! <= 400 && Int(rightDis)! <= 400 {
                driveModeImageView.image = UIImage(named: "BikeNearCar")
                serialMessageLabel1.textColor = UIColor.red
                serialMessageLabel2.textColor = UIColor.red
            }
            else if Int(leftDis)! <= 400 {
                driveModeImageView.image = UIImage(named: "BikeNearLeft")
                serialMessageLabel1.textColor = UIColor.red
            }
            else if Int(rightDis)! <= 400 {
                driveModeImageView.image = UIImage(named: "BikeNearRight")
                serialMessageLabel2.textColor = UIColor.red
            }
        } else {
            dangerousBetweenCount = 0
        }
            
        if Double(ang)! >= 40 {
            driveModeLabel.text = "지그재그 주행중!"
            driveModeImageView.image = UIImage(named: "BikeLeft.png")
            serialMessageLabel3.textColor = UIColor.red
            
        } else if Double(ang)! <= -40 {
            driveModeLabel.text = "지그재그 주행중!"
            driveModeImageView.image = UIImage(named: "BikeRight.png")
            serialMessageLabel3.textColor = UIColor.red
            
        } else {
            
            dangerousWarigariCount = 0
        }
        
        dangerousBetweenCount += 1
        dangerousWarigariCount += 1
        
        if dangerousBetweenCount > 5 {
            sendPostRequest(email: GlobalVariable.shared.userEmail!, content: "난폭운전 종류: 차간주행", latitude: latitude, longitude: longitude)
            dangerousBetweenDrive += 1
            dangerousBetweenCount = 0
        }
        if dangerousWarigariCount > 5 {
            sendPostRequest(email: GlobalVariable.shared.userEmail!, content: "난폭운전 종류: 와리가리", latitude: latitude, longitude: longitude)
            dangerousWarigariDrive += 1
            dangerousWarigariCount = 0
        }
        
        // 응답으로 온 메시지를 라벨에 표시합니다.
        serialMessageLabel1.text = leftDis + "mm"
        serialMessageLabel2.text = rightDis + "mm"
        serialMessageLabel3.text = ang + "°"
        
        dangerousBetweenDriveCount.text = String(dangerousBetweenDrive)
        dangerousWarigariDriveCount.text = String(dangerousWarigariDrive)
    }
    
    // 위치 정보 계속 업데이트 -> 위도 경도 받아옴
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    
    // 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

//    // API 요청 보내기
    // GET 요청 예시
    func sendGetRequest() {
        guard let url = URL(string: "http://121.159.178.99:8080/list/") else {
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
                            if let desiredValue = jsonObject["email"] as? String {
                                print("원하는 값: \(desiredValue)")
                            }
                        }
                    }
//                    let decoder = JSONDecoder()
//                    let myData = try decoder.decode(UserInfo.self, from: data)
//                    print(myData)
//                    print("원하는 값: \(myData.email)")
                } catch {
                    print("JSON 파싱 실패: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }

    // POST 요청 예시
    func sendPostRequest(email: String, content: String, latitude: Double, longitude: Double) {
        guard let url = URL(string: "http://121.159.178.99:8080/data/endpost") else {
            print("URL 생성에 실패했습니다.")
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let current_date_string = formatter.string(from: Date())

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // HTTP 요청에 필요한 데이터 설정 (요청 본문)
        let jsonData: [String: Any] = [
            "email":email,
            "type":content,
            "time":current_date_string,
            "latitude" : latitude,
            "longitude" : longitude
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonData)
        
        // HTTP 요청 헤더 설정 (필요시)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("요청 실패: \(error.localizedDescription)")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("응답 받음: \(responseString)")
            }
        }

        task.resume()
    }
}

//struct UserInfo: Codable {
//    var id: Int?
//    var email: String?
//    var password: String?
//    var roles: [String]?
//    var accountNonExpired: Bool?
//    var accountNonLocked: Bool?
//    var credentialsNonExpired: Bool?
//    var authorities: [String]?
//    var username: String?
//    var enabled: Bool?
//}
