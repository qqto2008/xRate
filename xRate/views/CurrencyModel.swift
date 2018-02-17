

import Foundation

struct CurrencyModel:Decodable {
    let base:String
    let date:String
    let rates:[String:Double]
}
