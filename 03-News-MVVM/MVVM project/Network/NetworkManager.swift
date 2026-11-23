import Foundation

enum ErrorsList: Error{
    case invalidURL, nullData, decodableError
}

class NetworkManager{
    //https://newsapi.org/v2/everything?q=tesla&from=2026-10-22&sortBy=publishedAt&apiKey=76d83cde510549e1a40eef2e76c60a71
    
    func sendRequest(q:String, completion: @escaping (Result<[News], Error>) -> Void){
        var urlComponents = URLComponents(string:"https://newsapi.org/v2/everything")
        urlComponents?.queryItems = [
            URLQueryItem(name: "apiKey", value: "API_KEY"),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "language", value: "ru")
        ]
        
        guard let url = urlComponents?.url else{
            completion(.failure(ErrorsList.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else{
                completion(.failure(error!))
                
                return
            }
            
            guard let data else{
                completion(.failure(ErrorsList.nullData))
                return
            }
            
            if let responce = try? JSONDecoder().decode(Responce.self, from: data){
                completion(.success(responce.articles))
            } else {
                completion(.failure(ErrorsList.decodableError))
            }
        }.resume()
    }
}


