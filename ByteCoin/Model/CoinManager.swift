//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate{
    func didUpdateBitcoinPrice(_ coinManager: CoinManager, bitcoin: BitcoinModel)
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let publicKey = "X-ba-key: NWY3MWE4Njk5NTE1NDJjZTk4NzdjMjM1ZDE1Njk4Njk"
    
    
    func performRequest(for currency: String) {
    let urlString = baseURL + currency
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if  let safeData = data {
                    if let bitcoin = self.parseJSON(safeData) {
                       self.delegate?.didUpdateBitcoinPrice(self, bitcoin: bitcoin)
                    
                   }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ bitcoinData: Data)  -> BitcoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(BitcoinData.self, from: bitcoinData)
            let lastPrice = decodedData.last
            
            let dayAverage = decodedData.averages.day
            let openHour = decodedData.open.hour
            let bitcoin = BitcoinModel(lastPrice: lastPrice, dayAverage: dayAverage, openHour: openHour)
            return bitcoin
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
