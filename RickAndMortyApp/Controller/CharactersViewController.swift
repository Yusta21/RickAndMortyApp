//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Noel H. Yusta on 16/4/24.
//

import UIKit

class CharactersViewController: UIViewController, APIResponseDelegate, UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var backPagebutton: UIButton!
    
    
    var character: [Character] = []
    var info: Info?
    let apiManager = APIManager()
    let mainAPI = "https://rickandmortyapi.com/api/character"
    var actualAPI = ""
    
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            apiManager.fetchData(delegate: self,API: mainAPI)
            actualAPI = mainAPI
            characterTableView.delegate = self
            characterTableView.dataSource = self
            generalConfigureButton(button: backButton)
            generalConfigureButton(button: reloadButton)
            generalConfigureRoundedButton(button: nextPageButton)
            generalConfigureRoundedButton(button: backPagebutton)
            characterTableView.isHidden = true
            startLoading(state: true)
            backPagebutton.isHidden = true
            nextPageButton.isHidden = true
            
        }
        
    
    
    //configuramos la tabla
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(character[indexPath.row])
        let celda = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        
        celda.setValues(name: character[indexPath.row].name,gender: character[indexPath.row].gender,imageUrl: character[indexPath.row].image)
        
        celda.selectionStyle = .none
        print("generado celda")
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return characterTableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailCharacterViewController: DetailCharacterViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailCharacterViewController") as! DetailCharacterViewController
        
        detailCharacterViewController.character = character[indexPath.row]
        self.navigationController?.pushViewController(detailCharacterViewController, animated: true)
        
    }
    
    
    func checkPagesButton(){
        if info?.next != nil{
            nextPageButton.isHidden = false
        } else {
            nextPageButton.isHidden = true
        }
        
        if info?.prev == nil {
            backPagebutton.isHidden = true
        } else {
            backPagebutton.isHidden = false

        }
        
    }
    
    func startLoading(state: Bool) {
        DispatchQueue.main.async {
            if state {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }

    
    // alerta con un botón de cancelar
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //protocolo APIResponseDelegate
    func didFetchDataSuccessfully(data: [String: Any]) {
        // Procesa los datos obtenidos
        do {
            // Parsea la respuesta en la estructura Info
            if let infoData = data["info"] as? [String: Any] {
                let infoJSONData = try JSONSerialization.data(withJSONObject: infoData, options: [])
                self.info = try JSONDecoder().decode(Info.self, from: infoJSONData)
                print("Info decodificada correctamente:", self.info!)
            } else {
                print("No se encontró información en la respuesta")
            }
            
            // Parsea los personajes en un array de estructuras Character
            if let charactersData = data["results"] as? [[String: Any]] {
                let charactersJSONData = try JSONSerialization.data(withJSONObject: charactersData, options: [])
                self.character = try JSONDecoder().decode([Character].self, from: charactersJSONData)
                print("Personajes decodificados correctamente:", self.character)
            } else {
                print("No se encontraron personajes en la respuesta")
            }
            
            // Recarga la tabla con los nuevos datos
            DispatchQueue.main.async {
                self.characterTableView.reloadData()
                self.startLoading(state: false)
                self.characterTableView.isHidden = false
                self.checkPagesButton()
                
                print("Tabla recargada")
            }
        } catch {
            // Maneja el error si ocurre algún problema durante el parsing
            print("Error al parsear los datos:", error)
            DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "Error al parsear datos: \(error)")
            }
        }
    }

       
       func didFailToFetchDataWithError(error: Error) {
           // Maneja el error
           startLoading(state: false)
           DispatchQueue.main.async {
               self.showAlert(title: "Error", message: "Error al obtener datos: \(error.localizedDescription)")
               print("Error al obtener datos:", error.localizedDescription)
           }
       }
   
    @IBAction func reloadPressed(_ sender: Any) {
        apiManager.fetchData(delegate: self, API: actualAPI)
        print("se hace reload")
    }
    
    @IBAction func nextPagePressed(_ sender: Any) {
        apiManager.fetchData(delegate: self, API: (info?.next)!)
        actualAPI = (info?.next)!
    }
    
    @IBAction func previousPagePressed(_ sender: Any) {
        apiManager.fetchData(delegate: self, API: (info?.prev)!)
        actualAPI = (info?.prev)!
    }
    
    @IBAction func reloadData(_ sender: Any) {
        
        characterTableView.reloadData()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
