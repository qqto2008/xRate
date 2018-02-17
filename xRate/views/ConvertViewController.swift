//
//  ConvertViewController.swift
//  xRate
//
//  Created by xianzhe yang on 8/2/18.
//  Copyright © 2018 hao. All rights reserved.
//

import UIKit

struct Currency:Decodable {
    
    let base:String
    let date:String
    let rates:[String:Double]
    
    
}

class ConvertViewController: UIViewController,UITableViewDataSource {
    
    

    
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var amountInputTextField: UITextField!
    @IBOutlet weak var currencyTableView: UITableView!
    var usd:CurrencyModel?
    var baseRate = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.dataSource = self
        currencyTableView.allowsSelection = false
        amountInputTextField.textAlignment = .center
        convertBtn.layer.cornerRadius=8
        fetchData()
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currencyFetched = usd {
            return currencyFetched.rates.count
        }else{
            print("error  convert 1")
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if let currencyFetched = usd {
            cell.textLabel?.text = Array(currencyFetched.rates.keys)[indexPath.row]
            let selectedRate =  baseRate*Array(currencyFetched.rates.values)[indexPath.row]
            cell.detailTextLabel?.text = "\(selectedRate)"
            return cell
            
            }
        return UITableViewCell()
        }
    
    
    @IBAction func convertBtn(_ sender: Any) {
        if let iGetString = amountInputTextField.text{
            if let isDouble = Double(iGetString){
                baseRate = isDouble
                fetchData()
            }else{
                
            }
        }
    }
    func fetchData() {
        let url = URL(string:"https://api.fixer.io/latest?base=USD")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error == nil{
                
                do{
                self.usd = try JSONDecoder().decode(CurrencyModel.self, from: data!)
                }catch{
                    print("Parse Error error  convert")
                }
                DispatchQueue.main.async {
                    self.currencyTableView.reloadData()
                }
            }else{
                print("error error  convert")
            }
        }.resume()
    }
    
    
}

