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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    
    
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
        generalConfigureRoundedButton(button: searchButton)
        characterTableView.isHidden = true
        startLoading(state: true)
        backPagebutton.isHidden = true
        nextPageButton.isHidden = true
        generalConfigureSearchBar(searchBar: searchBar)
        searchBar.isHidden = true
        searchButton.isHidden = true
        
        // Registra notificaciones para los eventos de teclado
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        addDoneButtonToKeyboard()
        
        
        
       // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         //      view.addGestureRecognizer(tapGesture)
        
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
        self.dismissKeyboard()
        let detailCharacterViewController: DetailCharacterViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailCharacterViewController") as! DetailCharacterViewController
        
        detailCharacterViewController.character = character[indexPath.row]
        self.navigationController?.pushViewController(detailCharacterViewController, animated: true)
        
    }
    
    //funciones
    
    func addDoneButtonToKeyboard() {
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
           toolbar.setItems([doneButton], animated: false)
           
           searchBar.inputAccessoryView = toolbar
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
        
        self.searchBar.isHidden = false
        self.searchButton.isHidden = false
        
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
    
    // Función para ajustar la posición de la vista cuando el teclado se muestra
    @objc func keyboardWillShow(_ notification: Notification) {
            guard let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            let keyboardHeight = keyboardFrame.size.height
            self.view.frame.origin.y = (-keyboardHeight + 195)
        }
        
        // Función para restaurar la posición de la vista cuando el teclado se oculta
    @objc func keyboardWillHide(_ notification: Notification) {
            self.view.frame.origin.y = 0
        }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    
    //protocolos APIResponseDelegate
    func didFetchDataSuccessfully(data: [String: Any]) {
        // Procesa los datos obtenidos
        print(data)
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
                self.startLoading(state: false)
                self.showAlert(title: "Error", message: "Error al parsear datos: \(error)")
            }
        }
    }
    
    
    func didFailToFetchDataWithError(error: Error) {
        // Maneja el error
        
        DispatchQueue.main.async {
            self.startLoading(state: false)
            self.showAlert(title: "Error", message: "Error al obtener datos: \(error.localizedDescription)")
            print("Error al obtener datos:", error.localizedDescription)
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            // Si el campo de búsqueda está vacío, muestra todos los personajes
            
            characterTableView.reloadData()
            return
        }
        
        // Filtra los personajes que contienen el texto de búsqueda
        self.character = character.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        characterTableView.reloadData()
            }
        
    
    
    @IBAction func reloadPressed(_ sender: Any) {
        apiManager.fetchData(delegate: self, API: actualAPI)
        searchBar.text = ""
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
