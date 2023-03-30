//
//  MovieSimilarViewModel.swift
//  MovieDB
//
//  Created by NeoSOFT on 13/03/23.
//
//https://api.themoviedb.org/3/movie/73492/similar?api_key=fad5b78120f977d5b9a0468f4f6ff44e
import Foundation

class MovieSimilarViewModel {

    var moviesimilar : MovieSimilar?
    var movie_id:Int?
//https://api.themoviedb.org/3/movie/{movie_id}?api_key={api_key}

    func movieDetailsSimilar(movie_id:Int,completion:@escaping ()->())
        {
            let session = URLSession.shared
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id)/similar?api_key=fad5b78120f977d5b9a0468f4f6ff44e")!
            
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data,
                          let response = response else { return }
                    
                    do {
                        let jSonData = try JSONDecoder().decode(MovieSimilar.self, from: data)
                        print("json data \(String(describing: jSonData))")
                        self.moviesimilar = jSonData
                        completion()
                    }
                    
                       catch let er {
                        print(er.localizedDescription)
                        debugPrint(er)
                    }
                }
                
            } .resume()

        }
}



