//
//  FirstViewController.swift
//  AngleConverter
//
//  Created by Logan Watkins on 11/27/20.
//  Copyright © 2020 Logan Watkins. All rights reserved.
//

import UIKit

//Handles all logic related to UI interaction as well as connecting to business logic and model
class ConvertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    //Connecting IBOutlets for UI elements on screen of convert view controller
    @IBOutlet weak var inputWavelengthPicker: UIPickerView!
    @IBOutlet weak var outputWavelengthPicker: UIPickerView!
    @IBOutlet weak var inputWavelengthTextField: UITextField!
    @IBOutlet weak var outputWavelengthTextField: UITextField!
    @IBOutlet weak var inputAngleTextField: UITextField!
    @IBOutlet weak var outputAngleTextField: UITextField!
    @IBOutlet weak var rulesLabel: UILabel!
    
    //Instance of convert model struct
    var convertInfo = ConvertModel()
    
    //Function executes upon loading view
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateConvertInfo()
        
        //Sets keyboard type for text field to be decimal pad rather than letters
        self.inputWavelengthTextField.keyboardType = .decimalPad
        self.outputWavelengthTextField.keyboardType = .decimalPad
        self.inputAngleTextField.keyboardType = .decimalPad
        
        //Needed for
        self.inputWavelengthTextField.delegate = self;
        self.outputWavelengthTextField.delegate = self;
        self.inputAngleTextField.delegate = self;

        //Adding handlers for text fields having user changes performed.
        inputAngleTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        inputWavelengthTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        outputWavelengthTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        //Setting delegates and datasources for the UIPickers
        self.inputWavelengthPicker.delegate = self
        self.inputWavelengthPicker.dataSource = self
        self.outputWavelengthPicker.delegate = self
        self.outputWavelengthPicker.dataSource = self
       
        //Displaying the initial values in the text fields
        inputWavelengthTextField.text = String(convertInfo.currentInLamda)
        outputWavelengthTextField.text = String(convertInfo.currentOutLamda)
    }
    
    //Instantiating converInfoModel with some constant data from struct K
    func instantiateConvertInfo(){
        convertInfo.currentInLamda = K.lamdaValues[0]
        convertInfo.currentInLamdaName = K.elementNames[0]
        convertInfo.outLamdaValues = K.lamdaValues
        convertInfo.currentOutLamda = K.lamdaValues[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                   return 1
    }
       
    //Determines picker size based on number of elements
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == inputWavelengthPicker {
                      return K.lamdaValues.count
                  } else if pickerView == outputWavelengthPicker{
                        return K.lamdaValues.count
                  }
                  return 1
    }
    
    //Handles user making any change to picker selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        if pickerView == inputWavelengthPicker {
            
            convertInfo.currentInLamda = K.lamdaValues[row]
            convertInfo.currentInLamdaName = K.elementNames[row]
            inputWavelengthTextField.text = String(K.lamdaValues[row])
            convertInfo.currentInLamdaName = String(K.elementNames[row])
            textFieldDidChange(textField: inputWavelengthTextField)
            
        } else if pickerView == outputWavelengthPicker{
            
            convertInfo.currentOutLamda = K.lamdaValues[row]
            convertInfo.currentOutLamdaName = K.elementNames[row]
            outputWavelengthTextField.text = String(K.lamdaValues[row])
            convertInfo.currentInLamdaName = String(K.elementNames[row])
            textFieldDidChange(textField: outputWavelengthTextField)
            
        }
    }
    
    //Fills out picker with element names
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == inputWavelengthPicker {
                convertInfo.currentOutLamdaName = K.elementNames[row]
                return K.elementNames[row]
            } else if pickerView == outputWavelengthPicker{
                convertInfo.currentOutLamdaName = K.elementNames[row]
                return K.elementNames[row]
            }
            return ""
        }
    
       
    @objc func textFieldDidChange(textField: UITextField){
        
        //Checking to make sure input is valid
        if let text = inputAngleTextField.text{
            if let inputAngle = Double(inputAngleTextField.text!), let testInputWave = Double(inputWavelengthTextField.text!), let testOutputWave =  Double(outputWavelengthTextField.text!){
                
                if(inputAngle > 0 && inputAngle <= 180){
                    convertInfo.currentInAngle = inputAngle
                    convertInfo.currentInLamda = Double(inputWavelengthTextField.text!)!
                    convertInfo.currentOutLamda = Double(outputWavelengthTextField.text!)!
                    
                    //Makes call to actual business logic to perform calculation
                    convertInfo.currentOutAngle = convertInfo.calculateOutputAngle()
                    
                    outputAngleTextField.text = String(convertInfo.currentOutAngle)
                    rulesLabel.text = ""
                    
                //Else will be triggered if inputs are not between 0 and 180
                }else{
                    rulesLabel.text = "Only input angles between 0 and 180 degrees"
                
                }
                
            //Else will be triggered if any inputs can not be converted to double type
            } else {
                rulesLabel.text = "Make sure input is numeric"
            }
        }
    }
    
    //Enables user to touch anywhere on screen to dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
