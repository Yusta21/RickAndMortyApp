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
func generalConfigureView(view:UIView){
    
    view.layer.cornerRadius = 10
    view.layer.shadowOffset = CGSize(width: 0, height: 0)
    view.layer.shadowOpacity = 0.6
    view.layer.shadowRadius = 4.0
    view.layer.borderWidth = 2
    view.backgroundColor = UIColor.lightGray
    view.layer.shadowColor = CGColor(red: 0.500, green: 0.827, blue: 0.077, alpha: 1)
    view.layer.borderColor = CGColor(red: 0.004, green: 0.792, blue: 0.843, alpha: 1)
}


func generalConfigureImageView(image:UIImageView){
    
    image.layer.borderColor = CGColor(red: 0.500, green: 0.827, blue: 0.077, alpha: 1)
    image.layer.borderWidth = 2
    image.layer.cornerRadius = 10
    

}

func generalConfigureRoundedButton(button:UIButton){
    
    button.layer.cornerRadius = 10
}

func generalConfigureSearchBar(searchBar:UITextField){
    
    searchBar.layer.borderColor = CGColor(red: 0.500, green: 0.827, blue: 0.077, alpha: 1)
    searchBar.layer.borderWidth = 1.5
    searchBar.layer.cornerRadius = 10
    searchBar.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
}

