

import UIKit

class PickCurrencyViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    @IBOutlet weak var convertBtn: UIButton!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var inputConvertAmountCurrency: UITextField!
    
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    var currency:CurrencyModel?
    var fetchData:CurrencyModel?
    var currencies:[String] = []
    var selectedFromCurrency:String = "RON"
    var selectedToCurrency:String = "RON"
    var exchangeRate:Double = 0.0
    var exchangeAmount:Double = 0.0
    
    let aus = "australia"
    let brazil = "brazil"
    let britain = "britain"
    let bulgaria = "bulgaria"
    let canada = "canada"
    let china = "china"
    let croatia = "croatia"
    let czech = "czech"
    let denmark = "denmark"
    let europe = "europe"
    let hongkong = "hongkong"
    let hungary = "hungary"
    let iceland = "iceland"
    let india = "india"
    let indonesia = "indonesia"
    let israel = "israel"
    let japan = "japan"
    let korea = "korea"
    let malaysia = "malaysia"
    let mexico = "mexico"
    let new_zealand = "new-zealand"
    let norway = "norway"
    let philippine = "philippine"
    let poland = "poland"
    let romania = "romania"
    let russian = "russian"
    let singapore = "singapore"
    let sweden = "sweden"
    let switzerland = "switzerland"
    let thai = "thai"
    let turkey = "turkey"
    let usa = "usa"

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        fetchCurrency()
        convertBtn.layer.cornerRadius = 8
        
    }
    
    func fetchCurrency() -> Void {
        let url = URL(string:"https://api.fixer.io/latest?base=ZAR")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                self.currency = try JSONDecoder().decode(CurrencyModel.self, from:data!)
                }catch{
                    print("error")
                }
                DispatchQueue.main.async {
                    self.currencyPicker.reloadAllComponents()
                }
                
            }
        }.resume()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let currencyFetched = currency {
            return currencyFetched.rates.count
        }else{
            return 3
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let currencyFetched = currency{
            
            for key in currencyFetched.rates.keys{
                currencies.append(key)
            }
            return currencies[row]
        
        }else{
            return " "
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            selectedFromCurrency = currencies[row]
            print(selectedFromCurrency)
        }else if component==1{
            selectedToCurrency = currencies[row]
            print(selectedToCurrency)
        }
        
    }
    @IBAction func convertButton(_ sender: Any) {
        
        
        
        
        
        
        
        self.fetchExchangeRate(from: self.selectedFromCurrency, to: self.selectedToCurrency,completion: updateLabel)
        
        
        
    }
    
    func fetchExchangeRate(from:String, to:String,completion:((_ x:Double)->())?) -> Double {
        var x:Double = 1.0
        if from != to {
        let baseURL = URL(string:"https://api.fixer.io/latest?base="+from)
        URLSession.shared.dataTask(with: baseURL!) { (data, response, error) in
            if error == nil{
                do{
                    self.fetchData = try JSONDecoder().decode(CurrencyModel.self, from:data!)
                    for (key,value) in (self.fetchData?.rates)!{
                        
                        if(key==to){
                            DispatchQueue.main.sync {
                                self.exchangeRate=value
                                x=value
                                completion?(x)
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }catch{
                    print("error")
                }
                
                
            }
            }.resume()
        }else{
            x=1.0
            completion?(x)
        }
        
        return x
        
    }
    func checkDouble(inputData:String) -> Bool {
        return Double(inputData) != nil
    }
    func updateLabel(x:Double) -> Void {
        if self.inputConvertAmountCurrency.text?.isEmpty==false{
            if self.checkDouble(inputData: self.inputConvertAmountCurrency.text!)==true{
                if let inputNum = Double(self.inputConvertAmountCurrency.text!){
                    
                    
                    self.exchangeAmount=inputNum*x
                    self.fromToLabel.text=self.selectedFromCurrency+"  to  "+self.selectedToCurrency
                    self.fromToLabel.textColor = UIColor.white
                    self.fromToLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: 40)
                    self.resultLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: 40)
                    self.resultLabel.text = String(self.exchangeAmount)
                    self.resultLabel.textColor = UIColor.white
                }
                
            }else{
                print("cannot parse to double")
            }
            
        }
    }
    // customise uipickerview
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 100, height: 80))
        let label = UILabel(frame:CGRect(x: 50, y: 0, width: 50, height: 80))
        var flagName:String?
        
        let flagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 80))
        
        flagView.contentMode = .scaleAspectFit
        
        if let currencyFetched = currency{
            
            for key in currencyFetched.rates.keys{
                currencies.append(key)
            }
            label.text = currencies[row]
            if currencies[row] == "RON" {
                flagName = romania
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "EUR" {
                flagName = europe
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "MYR" {
                flagName = malaysia
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "ISK" {
                flagName = iceland
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "CAD" {
                flagName = canada
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "DKK" {
                flagName = denmark
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "GBP" {
                flagName = britain
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "PHP" {
                flagName = philippine
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "CZK" {
                flagName = czech
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "PLN" {
                flagName = poland
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "RUB" {
                flagName = russian
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "SGD" {
                flagName = singapore
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "BRL" {
                flagName = brazil
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "JPY" {
                flagName = japan
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "SEK" {
                flagName = sweden
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "USD" {
                flagName = usa
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "HRK" {
                flagName = croatia
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "NZD" {
                flagName = new_zealand
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "HKD" {
                flagName = hongkong
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "BGN" {
                flagName = bulgaria
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "TRY" {
                flagName = turkey
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "MXN" {
                flagName = mexico
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "HUF" {
                flagName = hungary
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "KRW" {
                flagName = korea
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "NOK" {
                flagName = norway
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "INR" {
                flagName = india
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "ILS" {
                flagName = israel
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "IDR" {
                flagName = indonesia
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "CHF" {
                flagName = switzerland
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "THB" {
                flagName = thai
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "CNY" {
                flagName = china
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }else if currencies[row] == "AUD" {
                flagName = aus
                let flagImage = UIImage(named:flagName!)
                flagView.image=flagImage
                
            }
            
            
        }
        
        
        label.font = UIFont (name: "HelveticaNeue-UltraLight", size: 21)
        view.addSubview(label)
        view.addSubview(flagView)
        label.textColor = UIColor.white
        
        return view
    }
    
    
}
