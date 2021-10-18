//
//  ViewController.swift
//  tic tac toe
//
//  Created by Dipika Kansara on 18/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var startButton: UIButton!
    @IBOutlet var txtfield: UITextField!
    @IBOutlet var cardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setview()
       
    }
    
    func setview(){
        startButton.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = .zero
            
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtfield.resignFirstResponder()
    }
    
    
    @IBAction func startBtnPressed(_ sender: UIButton) {
        
        
        guard !txtfield.text!.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        controller.playername = txtfield.text
        self.present(controller, animated: true, completion: nil)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HomeViewController{
            controller.playername = txtfield.text
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "GOtoHOme"{
            if txtfield.text!.trimmingCharacters(in: .whitespaces).isEmpty{
                return false
                
            }
            
        }
        return true
        
        
    }
    
}

