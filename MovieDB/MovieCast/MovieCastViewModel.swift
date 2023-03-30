//
//  MovieCastViewModel.swift
//  MovieDB
//
//  Created by NeoSOFT on 02/03/23.
//

import Foundation



class MovieCastViewModel {
    var movieCast : MovieCast? 
    var movie_id:Int?
    func fetchMovieCast(movie_id:Int,completion:@escaping ()->())
        {
            let session = URLSession.shared
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id)/credits?api_key=fad5b78120f977d5b9a0468f4f6ff44e")!
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data,
                          let response = response else { return }
                    
                    do {
                        let jSonData = try JSONDecoder().decode(MovieCast.self, from: data)
                        let json = self.nsdataToJSON(data: data)
                        debugPrint(json as Any)
                        print("json data \(String(describing: jSonData))")
                        self.movieCast = jSonData
                        completion()
                    }
                    catch let er {
                        debugPrint(er)
                        print(er)
                    }
                }
                
            } .resume()

            
        }
    func nsdataToJSON(data: Data) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data,options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
