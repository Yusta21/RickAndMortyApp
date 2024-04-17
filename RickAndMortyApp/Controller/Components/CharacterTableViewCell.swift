//
//  CharacterTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Noel H. Yusta on 17/4/24.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var backView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        generalConfigureView(view: backView)
        generalConfigureImageView(image: characterImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func setValues(name: String, gender: String, imageUrl: URL?) {
        
        
        characterName.text = name
        characterGender.text = gender
        characterName.adjustsFontSizeToFitWidth = true
        characterGender.adjustsFontSizeToFitWidth = true
        
           if let url = imageUrl {
               // Cargamos y almacenamos en caché la imagen utilizando Kingfisher
               characterImage.kf.setImage(with: url)
           } else {
               // Si no hay una URL de imagen válida, establecemos la imagen de rick
               characterImage.image = UIImage(named: "rick")
           }
    }
}
