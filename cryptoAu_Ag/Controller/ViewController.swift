//
//  ViewController.swift
//  cryptoAu_Ag
//
//  Created by Tyler Silverman on 3/27/18.
//  Copyright © 2018 Tyler Silverman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let litecoinURL = "https://api.coinbase.com/v2/prices/LTC-USD/spot"
    let bitcoinURL = "https://api.coinbase.com/v2/prices/BTC-USD/spot"
    let cryptoCurrencyPriceModel = CryptoCurrencyPriceModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getLTCPrice(url: litecoinURL)
        getBTCPrice(url: bitcoinURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var LTCPrice: UILabel!
    @IBOutlet weak var BTCPrice: UILabel!
    @IBOutlet weak var cryptoRatio: UILabel!
    
    
    
    
    
    func getLTCPrice(url: String) {
        Alamofire.request(litecoinURL, method: .get).responseJSON { response in
            if response.result.isSuccess {
                
                print("Success")
                
                let litecoinJSON : JSON = JSON(response.result.value!)
                print(litecoinJSON)
                self.updateLitecoinPrice(json: litecoinJSON)
                
            } else {
                print("error")
                self.LTCPrice.text = "Connection Issues"
            }
        }
        
    }
    
    
    func updateLitecoinPrice(json : JSON) {
        let priceResult = json["data"]["amount"]
//        let priceResultLTC = json["data"]["amount"]
        cryptoCurrencyPriceModel.LTCamount = String(describing: priceResult)
        print(priceResult)
        updateUIWithLTCData()
    }
    
    func updateUIWithLTCData (){
        LTCPrice.text = "$ \(cryptoCurrencyPriceModel.LTCamount) / ŁTC"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(15)) {
            self.getLTCPrice(url: self.litecoinURL)
        }
    }

    func getBTCPrice(url: String) {
        Alamofire.request(bitcoinURL, method: .get).responseJSON { response in
            if response.result.isSuccess {
                
                print("Success")
                
                let bitcoinJSON : JSON = JSON(response.result.value!)
                print(bitcoinJSON)
                self.updatebitcoinPrice(json: bitcoinJSON)
                
            } else {
                print("error")
                self.BTCPrice.text = "Connection Issues"
            }
        }
    }
    
    
    func updatebitcoinPrice(json : JSON) {
        let priceResult = json["data"]["amount"]
//        let priceResultBTC = json["data"]["amount"]
        cryptoCurrencyPriceModel.BTCamount = String(describing: priceResult)
        print(priceResult)
        updateUIWithBTCData()
    }
    
    func updateUIWithBTCData (){
        BTCPrice.text = "$ \(cryptoCurrencyPriceModel.BTCamount) / ₿TC"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(15)) {
            self.getBTCPrice(url: self.bitcoinURL)
//            self.ratio()
        }
    }
    
//    func ratio() {
//        var cryptoRatio =
//
//    }
    
    
}
