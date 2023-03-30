//
//  File.swift
//  MovieDB
//
//  Created by NeoSOFT on 09/03/23.
//


import Foundation

// MARK: - MovieCast
struct MovieCast: Codable {
    let id: Int
    let cast, crew: [CastData]
}

// MARK: - Cast
struct CastData: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department, job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character = "character"
        case creditID = "credit_id"
        case order = "order"
        case department = "department"
        case job = "job"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.adult = try container.decode(Bool.self, forKey: .adult)
        } catch {
            self.adult = false
        }
        self.gender = try container.decode(Int.self, forKey: .gender)
        self.id = try container.decode(Int.self, forKey: .id)
        self.knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        self.name = try container.decode(String.self, forKey: .name)
        self.originalName = try container.decode(String.self, forKey: .originalName)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
       
        do {
            self.profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        } catch {
            self.profilePath = nil
        }
        self.castID = try container.decodeIfPresent(Int.self, forKey: .castID)
        self.character = try container.decodeIfPresent(String.self, forKey: .character)
        self.creditID = try container.decode(String.self, forKey: .creditID)
        self.order = try container.decodeIfPresent(Int.self, forKey: .order)
        self.department = try container.decodeIfPresent(String.self, forKey: .department)
        self.job = try container.decodeIfPresent(String.self, forKey: .job)
    }

}
