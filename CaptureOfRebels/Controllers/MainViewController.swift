//
//  ViewController.swift
//  CaptureOfRebels
//
//  Created by Javier Sánchez Daza on 18/10/2018.
//  Copyright © 2018 Javier Sánchez Daza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    // UIView references
    @IBOutlet weak var tfRebelName: UITextField!
    @IBOutlet weak var tfPlanet: UITextField!
    
    @IBOutlet weak var btt_Register: UIButton!
    
    // Set color white at status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide keyboard
        self.hideKeyboardWhenTappedAround()
        
        // Set delegates in textFields
        tfRebelName.delegate = self
        tfPlanet.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set style register Button
        stylizeButton(button: btt_Register)
    }
    
    // Action for register button
    @IBAction func btt_RegAction(_ sender: UIButton) {
        
        // Fetch text in Text Views
        guard let name = self.tfRebelName.text, name != "" else {
            showAllert(title: "Error!", message: "Name cannot be empty")
            return
        }
        guard let planet = self.tfPlanet.text, planet != "" else {
            showAllert(title: "Error!", message: "Planet cannot be empty")
            return
        }
        
        // Create rebel object
        let rebelInfo = Rebel(name: name, planet: planet, time: Date())
        
        // Persist rebel in UserDefaults
        let persistManager = PersistRebel()
        persistManager.save(rebel: rebelInfo)
        
        // Show alert with rebel information
        let register = PrepareRegister()
        let result = register.reg(rebelInfo)
        showAllert(title: "REGISTER DONE", message: result)
    }
    
    // Set style button
    func stylizeButton(button: UIButton) {
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor;
    }
    
    // Hide keyboard on return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true;
    }
    
    //Clean text of a TextField
    func clearTextField(textField: UITextField) {
        textField.text = ""
    }
    
    // Shows alert to user
    func showAllert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                // Clean text after press button OK
                self.clearTextField(textField: self.tfPlanet)
                self.clearTextField(textField: self.tfRebelName)
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    // Method for hide keyboard in touch screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
