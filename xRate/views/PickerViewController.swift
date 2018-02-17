

import UIKit




class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    
    
    
    var currencyModel:CurrencyModel?
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate=self
        currencyPicker.dataSource=self
        fetchData()
        
    }
    
    
    func fetchData() -> Void {
        let url = URL(string:"https://api.fixer.io/latest?base=AUD")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data!)
                    print(self.currencyModel?.rates.count ?? "error")
                    
                }catch{
                    print("error 1")
                }
                DispatchQueue.main.async {
                    self.currencyPicker.reloadAllComponents()
                    
                }
                
            }else{
                print("error 2")
            }
        }.resume()
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if let num = currencyModel{
            return num.rates.count
        }else{
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    
    
    
}
