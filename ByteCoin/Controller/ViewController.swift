//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinPrice: UILabel!
    
    var coinManager = CoinManager()
    var selectedCurrency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        coinManager.performRequest(for: "USD")
      
      
    }
}
//MARK:  - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = coinManager.currencyArray[row]
        coinManager.performRequest(for: selectedCurrency)
        currencyLabel.text = coinManager.currencyArray[row]
        
    }
}

//MARK:  - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateBitcoinPrice(_ coinManager: CoinManager, bitcoin: BitcoinModel) {
        DispatchQueue.main.async {
           self.bitcoinPrice.text = String(bitcoin.lastPrice)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

