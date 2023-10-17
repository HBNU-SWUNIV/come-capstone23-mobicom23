//
//  LoginViewController.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/3/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var PWTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBAction func Login(_ sender: UIButton){
        GlobalVariable.shared.userEmail = IDTextField.text
        sendGetRequest(email:IDTextField.text ?? "")
        
        let vcSerial = self.storyboard?.instantiateViewController(withIdentifier: "UITabBarController")
        self.navigationController?.pushViewController(vcSerial!, animated: true)
    }
    
    func sendGetRequest(email: String) {
        guard let url = URL(string: "\(GlobalVariable.shared.apiURL)/list/\(email)") else {
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

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("응답 받음: \(responseString)")
            }
        }

        task.resume()
    }
}

