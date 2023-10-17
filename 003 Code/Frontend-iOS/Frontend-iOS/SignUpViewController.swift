//
//  SignUpViewController.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/4/23.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var NewIDTextField: UITextField!
    @IBOutlet weak var NewPWTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var BirthTextField: UITextField!
    @IBOutlet weak var CarNumberTextField: UITextField!
    @IBOutlet weak var PhoneNumberIDTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var RegistrationButton: UIButton!
    
    @IBAction func SignUp(_ sender: UIButton!){
        if NewIDTextField.text == ""{
            print("no")
        }
        if NewPWTextField.text == ""{
            print("no")
        }
        sendPostRequest(email: NewIDTextField.text!, pw: NewPWTextField.text!, name: NameTextField.text!, birth: BirthTextField.text!, car_number: CarNumberTextField.text!, phone_number: PhoneNumberIDTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    // POST 요청 예시
    func sendPostRequest(email: String, pw: String, name: String, birth: String, car_number: String, phone_number: String) {
        guard let url = URL(string: "\(GlobalVariable.shared.apiURL)/join") else {
            print("URL 생성에 실패했습니다.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // HTTP 요청에 필요한 데이터 설정 (요청 본문)
        let jsonData: [String: Any] = [
            "email":email,
            "password":pw,
            "name":name,
            "birth":birth,
            "car_number":car_number,
            "phone_number":phone_number
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

