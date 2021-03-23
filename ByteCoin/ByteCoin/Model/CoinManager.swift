//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(_ error: Error? )
    func didGetData(price: Double, coin: String)
}

struct CoinData: Decodable {
    let rate: Double
    let asset_id_quote: String
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "D48214FB-05F8-4F78-9B31-8B32EF9CF8D4"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","COP","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency:String) {
        let formatedURL = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=\(apiKey)"
        print(formatedURL)
        performRequest(with: formatedURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(safeData) 

                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ exchange: Data) -> String? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: exchange)
            
            delegate?.didGetData(price: decodedData.rate, coin: decodedData.asset_id_quote)
            
            return nil
        
        }catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    

}
