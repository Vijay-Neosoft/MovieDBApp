//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by NeoSOFT on 01/03/23.
//

import Foundation

class MovieListViewModel {

    var movieList : MovieList?
    func fetchMovieDetails(completion:@escaping ()->())
        {
            let session = URLSession.shared
            let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=fad5b78120f977d5b9a0468f4f6ff44e")!
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data,
                          let response = response else { return }
                    
                    do {
                        let jSonData = try JSONDecoder().decode(MovieList.self, from: data)
                        print("json data \(String(describing: jSonData))")
                        self.movieList = jSonData
                        completion()
                     
                    } catch let er {
                        debugPrint(er)
                        print(er.localizedDescription)
                    }
                }
                
            } .resume()
 
        }
    }


