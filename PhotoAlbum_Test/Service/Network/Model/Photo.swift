//
//  Photo.swift
//  PhotoAlbum_Test
//
//  Created by Артём Устинов on 03.02.2021.
//

struct Photo: Decodable {
    let albumId: Int?
    let title: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case title
        case photo = "url"
    }
}
