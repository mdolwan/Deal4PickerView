//
//  ViewController.swift
//  PikerView
//
//  Created by Mohammad Olwan on 10/11/2022.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var mypicker = UIPickerView()
    var lastPressedTextField: UITextField?
    var hourArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,00]
    var dayArray = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var yearArray = [1999, 2000, 2001, 2002, 2003, 2004, 2004, 2005, 2006, 2007, 2008, 2009, 2010]
    var year = Int()
    let toolBar = UIToolbar(frame:CGRect(x:0, y:0, width:100, height:100))
    var currentIndex = 0
    
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mypicker.tag = 1
        mypicker.delegate = self
        mypicker.dataSource = self
        hourTextField.delegate = self
        dayTextField.delegate = self
        monthTextField.delegate = self
        hourTextField.inputView = mypicker
        dayTextField.inputView = mypicker
        monthTextField.inputView = mypicker
        
        // MARK: - Add BarButton To PickerView
        toolBar.sizeToFit()
        let buttonDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePicker))
        toolBar.setItems([buttonDone], animated: true)
    }
    func textFieldDidBeginEditing(_ sender: UITextField) {
        lastPressedTextField = sender
        lastPressedTextField?.inputAccessoryView = toolBar
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            if lastPressedTextField == hourTextField {
                return hourArray.count
            } else if lastPressedTextField == dayTextField {
                return  dayArray.count
            } else if lastPressedTextField == monthTextField {
                return  monthArray.count
            }
        } else if pickerView.tag == 2 {
            return yearArray.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
        if lastPressedTextField == hourTextField {
            return String(hourArray[row])
        } else if lastPressedTextField == dayTextField {
            return  dayArray[row]
        } else if lastPressedTextField == monthTextField {
            return  monthArray[row]
        }
        } else if pickerView.tag == 2 {
            return String(yearArray[row])
        }
        
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
        if lastPressedTextField == hourTextField {
            hourTextField.text = String(hourArray[row])
        } else if lastPressedTextField == dayTextField {
            dayTextField.text =  dayArray[row]
        } else if lastPressedTextField == monthTextField {
            monthTextField.text = monthArray[row]
        }
        } else if pickerView.tag == 2 {
            year = yearArray[row]
        }
        self.view.endEditing(true)
    }
    @IBAction func AddYear(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Year", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let  pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        pickerFrame.tag = 2
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.year = (self.year == 0) ? 1999 : self.year
            print(self.year)
        }))
        present(alert, animated: true)
    }
    
}

extension ViewController{
    
    // MARK: - For Hide PickerView
    @objc func closePicker(){
        if lastPressedTextField == hourTextField {
            hourTextField.text = String(hourArray[currentIndex])
        } else if lastPressedTextField == dayTextField {
            dayTextField.text = dayArray[currentIndex]
        }else if lastPressedTextField == monthTextField {
            monthTextField?.text = monthArray[currentIndex]
        }
        view.endEditing(true)
    }
}
