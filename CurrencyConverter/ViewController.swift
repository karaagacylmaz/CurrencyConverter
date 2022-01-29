//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Yılmaz Karaağaç on 1/29/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //For Accept HTTP, Add "App Transport Security Settings > Allow Arbitrary Loads" permissions to info.plist
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        //Request & Session
        //Response & Data
        //Parsing & JSON Serialize
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=56a0457b08463fa9d24ee1690afe4266")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let baseCurrency = jsonResponse["base"] as? String {
                                self.currencyLabel.text = "Base Currency: \(baseCurrency)"
                            }
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let turkishLira = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkishLira)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                            }
                        }
                    } catch {
                        print("error in parsing data")
                    }
                }
            }
        }
        
        task.resume()
    }
    
}

