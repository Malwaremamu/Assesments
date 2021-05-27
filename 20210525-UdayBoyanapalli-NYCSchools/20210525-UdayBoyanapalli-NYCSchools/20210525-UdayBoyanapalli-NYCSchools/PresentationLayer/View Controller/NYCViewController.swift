//
//  ViewController.swift
//  20210525-UdayBoyanapalli-NYCSchools
//
//  Created by Boyanapalli, Uday on 5/25/21.
//

import UIKit
import Alamofire

class NYCViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var nycTableView: UITableView!
    var results = [SchoolBO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nycTableView.register(UINib(nibName: "NYCTableViewCell", bundle: nil), forCellReuseIdentifier: "nycTableViewCell")
        nycTableView.delegate = self
        nycTableView.dataSource = self
    }
    
    //MARK:- NYC Button Action
    //Show NYC Schools button
    @IBAction func showNycSchools(_ sender: Any) {
        results = []
        //Alamore Fire Request for NYC json Data
        AF.request("https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [Any]{
                    for item in json {
                        
                        let valueItem = item as? Dictionary<String, Any>
                        let dbn = valueItem?["dbn"] as! String
                        let schoolName = valueItem?["school_name"] as! String
                        let address = valueItem?["location"] as! String
                        let totalStudents = valueItem?["total_students"] as! String
                        let website = valueItem?["website"] as! String
                        
                        //Adding data to data object
                        let schoolBo = SchoolBO(dbn: dbn, schoolName: schoolName, address: address, totalStudents: totalStudents, website: website)
                       self.results.append(schoolBo)
                    }
                    DispatchQueue.main.async {
                        self.nycTableView.reloadData()
                    }
                }
            case .failure(_):
                print("Error")
            }
        }
    }
}


//MARK:- Tableview Delegate Methods
extension NYCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchItem = self.results[indexPath.row]
        let saTVc = SATViewController(nibName: "SATViewController", bundle: nil)
        saTVc.dbn = searchItem.dbn
        self.navigationController?.pushViewController(saTVc, animated: true)
    }
}

extension NYCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"nycTableViewCell", for: indexPath) as! NYCTableViewCell
        let searchItem = self.results[indexPath.row]
        cell.schoolName.text = "School Name: \(searchItem.schoolName)"
        cell.address.text = "Address: \(searchItem.address)"
        cell.totalStudents.text = "Total Students: \(searchItem.totalStudents)"
        cell.website.text = "Website: \(searchItem.website)"
        return cell
    }
    
    
}

