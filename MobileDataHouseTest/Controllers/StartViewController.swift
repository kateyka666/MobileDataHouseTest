//
//  ViewController.swift
//  MobileDataHouseTest
//
//  Created by Екатерина Боровкова on 29.08.2021.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var requestTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    

    @IBAction func nextButtonTapped(_ sender: Any) {
        guard requestTextField.text != nil else { return }
        if let newViewController = storyboard?.instantiateViewController(withIdentifier: "Images") as? ImagesCollectionViewController {
            newViewController.modalTransitionStyle = .flipHorizontal
            newViewController.textRequest = requestTextField.text
            present(newViewController, animated: false, completion: nil)
           }
    }
    

}
extension StartViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacter = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacter.isSuperset(of: characterSet)
    }
}
