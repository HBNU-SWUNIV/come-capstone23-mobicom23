//
//  SettingViewController.swift
//  Frontend-iOS
//
//  Created by Mjolnir on 9/4/23.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRank: UILabel!
    @IBOutlet weak var userRankImage: UIImageView!
    
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func sendGetRequest(email: String) {
//        guard let url = URL(string: "http://121.159.178.99:8080/list/\(email)") else {
        guard let url = URL(string: "http://172.17.47.4:8080/list/\(email)") else {
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
                        for jsonObject in jsonArray {
                            let name = jsonObject["name"] as? String
                            if let rank = jsonObject["rank"] as? String {
                                self.userName.text = name! + " 님"
                                self.userRank.text = rank
                                
                                if rank == "초록 등급" {
                                    self.userRankImage.image = UIImage(named: "greenRank.png")
                                } else if rank == "노랑 등급" {
                                    self.userRankImage.image = UIImage(named: "yellowRank.png")
                                } else if rank == "빨강 등급" {
                                    self.userRankImage.image = UIImage(named: "redRank.png")
                                }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let settingTitle = ["기록 보기", "알림 설정"]
        
        cell.textLabel?.text = settingTitle[indexPath.row]
        
        return cell
    }
}
