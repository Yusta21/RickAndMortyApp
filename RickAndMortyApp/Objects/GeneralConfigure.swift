//
//  GeneralConfigure.swift
//  RickAndMortyApp
//
//  Created by Noel H. Yusta on 16/4/24.
//

import Foundation
import UIKit


func generalConfigureButton(button:UIButton){
    
    button.layer.cornerRadius = 10
    button.layer.shadowOffset = CGSize(width: 0, height: 0)
    button.layer.shadowOpacity = 0.6
    button.layer.shadowRadius = 8.0
    button.layer.borderWidth = 2
    button.backgroundColor = UIColor(named: "Rickblue")
    button.titleLabel?.textColor = UIColor.black
    button.layer.shadowColor = CGColor(red: 0.500, green: 0.827, blue: 0.077, alpha: 1)
    
    

}
