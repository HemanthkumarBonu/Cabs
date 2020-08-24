//
//  CitySearchControllerViewController.swift
//  Busyee
//
//  Created by Anil Kumar Botsa on 29/01/20.
//  Copyright © 2020 i2Space Web Technologies. All rights reserved.
//


import UIKit

protocol CitySelectedDelegate {
    func selectedCity(city: SourceCity)
    func selectedData(data:String)
}


class CitySearchControllerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var sourcesArray:[SourceCity] = Array()
    var searchedArray:[SourceCity] = Array()
    var delegate: CitySelectedDelegate? = nil
    var tripType = 0
    var transFerType = 0
    var fieldTag = 0
    var selectedCity = ""
    var selectedCityID = ""
    var airPortsArray:[String] = Array()
    var hotelsArray:[String] = Array()
    var railwayStations:[String] = Array()
    var combinedSources:[String] = Array()
    
    var topCities:[SourceCity] = [SourceCity.init(dict: [ "Id": "188",
        "Name": "Mumbai"]),SourceCity.init(dict: [   "Id": "207",
        "Name": "Pune"]),SourceCity.init(dict: [  "Id": "113",
        "Name": "Bangalore"]),SourceCity.init(dict: [  "Id": "140",
        "Name": "Goa"]),SourceCity.init(dict: [  "Id": "135",
        "Name": "Delhi"]),SourceCity.init(dict: [   "Id": "11673",
        "Name": "New Delhi"]),SourceCity.init(dict: [    "Id": "150",
        "Name": "Indore"]),SourceCity.init(dict: [     "Id": "124",
        "Name": "Chennai"]),SourceCity.init(dict: [ "Id": "102",
        "Name": "Ahmedabad"]),SourceCity.init(dict: [  "Id": "170",
        "Name": "Kolkata"]),SourceCity.init(dict: [  "Id": "127",
        "Name": "Coimbatore"]),SourceCity.init(dict: [  "Id": "149",
        "Name": "Hyderabad"]),SourceCity.init(dict: [  "Id": "8753",
        "Name": "Bhubaneswar"]),SourceCity.init(dict: [  "Id": "203",
        "Name": "Patna"]),SourceCity.init(dict: [ "Id": "234",
        "Name": "Vishakhapatnam"]),SourceCity.init(dict: [  "Id": "227",
           "Name": "Tirupati"])]
    
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tripType == 3 {
            if fieldTag == 202 {
                switch transFerType {
                case 0:
                    return airPortsArray.count
                case 1:
                    return railwayStations.count
                case 2:
                    return hotelsArray.count
                default:
                    return airPortsArray.count

                }
            }
            if fieldTag == 203 {
                return combinedSources.count
            }
            return searchedArray.count
        }
        return searchedArray.count
    }
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
                if searchedArray.count > 12 {
    
                        return "Search City"
                    }
                    else{
                        return "Top Cities"
                    }
          }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.backgroundColor = UIColor.white
        }
        
        
        if tripType == 3 {
            if fieldTag == 202 {
                switch transFerType {
                case 0:
                    cell?.textLabel?.text = airPortsArray[indexPath.row]
                case 1:
                    cell?.textLabel?.text = railwayStations[indexPath.row]
                case 2:
                    cell?.textLabel?.text = hotelsArray[indexPath.row]
                default:
                    cell?.textLabel?.text = airPortsArray[indexPath.row]
                }
            }
            else if fieldTag == 203 {
                    cell?.textLabel?.text = combinedSources[indexPath.row]
            }
            else{
                let obj = self.searchedArray[indexPath.row]
                cell?.textLabel?.text = obj.name
            }
        }
        else {
            let obj = self.searchedArray[indexPath.row]
            cell?.textLabel?.text = obj.name
        }
        return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tripType == 3 {
            if self.fieldTag == 202 {
                var str = ""
                switch transFerType {
                case 0:
                     str = self.airPortsArray[indexPath.row]
                case 1:
                    str = self.railwayStations[indexPath.row]
                case 2:
                    str = self.hotelsArray[indexPath.row]
                default:
                    str = self.airPortsArray[indexPath.row]
                }
                if self.delegate != nil {
                    self.delegate?.selectedData(data: str)
                    dismiss(animated: true, completion: nil)
                }
            }
            else if self.fieldTag == 203 {
                let  str = self.combinedSources[indexPath.row]
                if self.delegate != nil {
                    self.delegate?.selectedData(data: str)
                    dismiss(animated: true, completion: nil)
                }
            }
            else {
                let obj = self.searchedArray[indexPath.row]
                if self.delegate != nil {
                    self.delegate?.selectedCity(city: obj)
                    dismiss(animated: true, completion: nil)
                }
            }
        }else {
            let obj = self.searchedArray[indexPath.row]
            if self.delegate != nil {
                self.delegate?.selectedCity(city: obj)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    

    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var searchresultsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchresultsTV.delegate = self
        self.searchresultsTV.dataSource = self
        self.searchtextField.delegate = self
        self.searchedArray.append(contentsOf: self.topCities)
        // Do any additional setup after loading the view.
        
        switch transFerType {
        case 0:
            self.combinedSources =  railwayStations + hotelsArray
            break
        case 1:
            self.combinedSources =  airPortsArray + hotelsArray
            break
        case 2:
            self.combinedSources =  airPortsArray + railwayStations +  hotelsArray
            break
        default:
            self.combinedSources =  airPortsArray + railwayStations +  hotelsArray
            break
        }

        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if tripType == 3 {
            if self.fieldTag == 202 {
                if (searchtextField.text?.count)! != 0 {
                    
                    var array = [String]()
                    
                    switch transFerType {
                    case 0:
                         array = self.airPortsArray
                         self.airPortsArray.removeAll()
                    case 1:
                        array = self.railwayStations
                        self.railwayStations.removeAll()
                    case 2:
                        array = self.hotelsArray
                        self.hotelsArray.removeAll()
                    default:
                        array = self.airPortsArray
                        self.airPortsArray.removeAll()
                    }
                    for str in array {
                        let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            switch transFerType {
                            case 0:
                                 self.airPortsArray.append(str)
                            case 1:
                                self.railwayStations.append(str)
                            case 2:
                                self.hotelsArray.append(str)
                            default:
                                self.airPortsArray.append(str)
                            }
                        }
                    }
                }
            }
            else if self.fieldTag == 203 {
                if (searchtextField.text?.count)! != 0 {

                    let array = self.combinedSources
                    self.combinedSources.removeAll()
                    for obj in array {
                        let range = obj.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.combinedSources.append(obj)
                        }
                    }
                }
            }
            else {
                if (searchtextField.text?.count)! != 0 {
                    self.searchedArray.removeAll()
                    for obj in sourcesArray {
                        let range = obj.name.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.searchedArray.append(obj)
                        }
                    }
                }
            }
            searchresultsTV.reloadData()
            return true
        }
            if (searchtextField.text?.count)! != 0 {
                self.searchedArray.removeAll()
                for obj in sourcesArray {
                    let range = obj.name.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.searchedArray.append(obj)
                    }
                }
            }
        searchresultsTV.reloadData()
        return true
    }


}
