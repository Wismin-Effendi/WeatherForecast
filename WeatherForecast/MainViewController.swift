//
//  MainViewController.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/28/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityTextField.becomeFirstResponder()  // automatically in edit mode on this text field.
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowResult" {
            if let resultVC = segue.destination as? ForecastTableViewController {
                resultVC.cityName = cityName!
            }
        }
    }
 
    @IBAction func goButtonTapped(_ sender: UIButton) {
        guard let city = cityTextField.text, city != "" else {
            return
        }
        view.endEditing(true)  // hide keyboard
        cityName = city
        performSegue(withIdentifier: "ShowResult", sender: self)

    }


}
