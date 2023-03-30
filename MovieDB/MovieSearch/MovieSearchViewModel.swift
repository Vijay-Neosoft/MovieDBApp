//
//  MovieSearchViewModel.swift
//  MovieDB
//
//  Created by NeoSOFT on 14/03/23.
//

//https://api.themoviedb.org/3/search/movie?api_key=fad5b78120f977d5b9a0468f4f6ff44e&query=dd

import Foundation
class MovieSearchViewModel{
//    var searchResults: [MovieList] = []
   var movieSearchList : MovieList?
    func fetchMovieDetails(searchStr:String,completion:@escaping ()->())
        {
            let session = URLSession.shared
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=fad5b78120f977d5b9a0468f4f6ff44e&query=\(searchStr)")!
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data,
                          let response = response else { return }
                    
                    do {
                        let jSonData = try JSONDecoder().decode(MovieList.self, from: data)
                        print("json data \(String(describing: jSonData))")
                        self.movieSearchList = jSonData
                        completion()
                     
                    } catch let er {
                        debugPrint(er)
                        print(er.localizedDescription)
                    }
                }
                
            } .resume()

            
        }
    
}
