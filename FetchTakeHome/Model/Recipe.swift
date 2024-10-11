//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/10/24.
//

import Foundation

final class Recipe: Codable, Identifiable {
    public var uuid: UUID
    public var name: String
    public var cuisine: String
    public var imageLargeURL: String
    public var imageSmallURL: URL
    public var sourceUrl: String
    public var youtubeUrl: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case cuisine
        case imageUrlLarge = "photo_url_large"
        case imageUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(cuisine, forKey: .cuisine)
        try container.encode(imageLargeURL, forKey: .imageUrlLarge)
        try container.encode(imageSmallURL, forKey: .imageUrlSmall)
        try container.encode(sourceUrl, forKey: .sourceUrl)
        try container.encode(youtubeUrl, forKey: .youtubeUrl)
    }
    
    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decodeIfPresent(UUID.self, forKey: .uuid) ?? UUID()
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        cuisine = try container.decodeIfPresent(String.self, forKey: .cuisine) ?? ""
        imageLargeURL = try container.decodeIfPresent(String.self, forKey: .imageUrlLarge) ?? ""
        imageSmallURL = try container.decodeIfPresent(URL.self, forKey: .imageUrlSmall) ?? URL(filePath: "")!
        sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl) ?? ""
        youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl) ?? ""
    }
    
    init(uuid: UUID, name: String, cuisine: String, imageUrlLarge: String, imageUrlSmall: URL, sourceUrl: String?, youtubeUrl: String?) {
        self.uuid = uuid
        self.name = name
        self.cuisine = cuisine
        self.imageLargeURL = imageUrlLarge
        self.imageSmallURL = imageUrlSmall
        self.sourceUrl = sourceUrl ?? ""
        self.youtubeUrl = youtubeUrl ?? ""
    }
}
