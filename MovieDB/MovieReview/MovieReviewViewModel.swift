//
//  MovieReviewViewModel.swift
//  MovieDB
//
//  Created by NeoSOFT on 10/03/23.
//

//https://api.themoviedb.org/3/movie/73492/reviews?api_key=fad5b78120f977d5b9a0468f4f6ff44e

import Foundation
class MovieReviewViewModel{
    var moviereview : MovieReviews?
    var movie_id:Int?
//https://api.themoviedb.org/3/movie/{movie_id}?api_key={api_key}

    func moviereviewDetails(movie_id:Int,completion:@escaping ()->())
        {
            let session = URLSession.shared
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id)/reviews?api_key=fad5b78120f977d5b9a0468f4f6ff44e")!
            
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data,
                          let response = response else { return }
                    
                    do {
                        let json = self.nsdataToJSON(data: data)
                        debugPrint(json as Any)
                        let jSonData = try JSONDecoder().decode(MovieReviews.self, from: data)
                        print("json data \(String(describing: jSonData))")
                        self.moviereview = jSonData
                        completion()
                    }
                       catch let er {
                        print(er.localizedDescription)
                        debugPrint(er)
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


