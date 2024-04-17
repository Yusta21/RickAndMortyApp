import UIKit



class APIManager {
    func fetchData(delegate: APIResponseDelegate,API:String) {
        guard let url = URL(string: API) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL no válida"])
            delegate.didFailToFetchDataWithError(error: error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                delegate.didFailToFetchDataWithError(error: error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error en la respuesta del servidor"])
                delegate.didFailToFetchDataWithError(error: error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])
                delegate.didFailToFetchDataWithError(error: error)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    delegate.didFetchDataSuccessfully(data: json)
                }
            } catch {
                delegate.didFailToFetchDataWithError(error: error)
            }
        }
        
        task.resume()
    }
    
    
    
}


protocol APIResponseDelegate: AnyObject {
    func didFetchDataSuccessfully(data: [String: Any])
    func didFailToFetchDataWithError(error: Error)
}
