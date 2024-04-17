//
//  DetailCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Noel H. Yusta on 17/4/24.
//

import UIKit

class DetailCharacterViewController: UIViewController {

    
    
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var characterSpecies: UILabel!
    @IBOutlet weak var characterOrigin: UILabel!
    @IBOutlet weak var characterLocation: UILabel!
    
    var character:Character?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        generalConfigureView(view: detailView)
        generalConfigureButton(button: backButton)
        generalConfigureImageView(image: characterImage)
        setValues()
    }
    
    func setValues(){
        
        if let url = character?.image {
            // Cargamos y almacenamos en caché la imagen utilizando Kingfisher
            characterImage.kf.setImage(with: url)
        } else {
            // Si no hay una URL de imagen válida, establecemos la imagen de rick
            characterImage.image = UIImage(named: "rick")
        }
        
        characterName.text = character?.name
        characterGender.text = character?.gender
        characterSpecies.text = character?.species
        if character?.status == "Alive" {
            characterStatus.textColor = UIColor.green
        } else {
            characterStatus.textColor = UIColor.red
        }
        characterStatus.text = character?.status
        characterOrigin.text = "Origin: \(character?.origin.name ?? "Unknown")"
        characterLocation.text = "Location: \(character?.location.name ?? "Unknown")"
        characterOrigin.adjustsFontSizeToFitWidth = true
        characterLocation.adjustsFontSizeToFitWidth = true
        characterSpecies.adjustsFontSizeToFitWidth = true
        characterName.adjustsFontSizeToFitWidth = true

        
        
    }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
