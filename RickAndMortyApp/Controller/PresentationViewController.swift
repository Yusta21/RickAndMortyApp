//
//  PresentationViewController.swift
//  RickAndMortyApp
//
//  Created by Noel H. Yusta on 17/4/24.
//

import UIKit

class PresentationViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var charactersButton: UIButton!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        introLabel.text = "Noel Hernandez Yusta \n\nnoelyusta@hotmail.com \n\nRick and Morty App"
        introLabel.adjustsFontSizeToFitWidth = true
        generalConfigureButton(button: charactersButton)
        charactersButton.titleLabel?.adjustsFontSizeToFitWidth = true
    
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func charactersPressed(_ sender: Any) {
        
        let charactersViewController: CharactersViewController = self.storyboard?.instantiateViewController(withIdentifier: "CharactersViewController") as! CharactersViewController
        
        self.navigationController?.pushViewController(charactersViewController, animated: true)
        
    }
    
}

