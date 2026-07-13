// Model/GitHubRepo.swift

import Foundation

public struct GitHubRepo: Identifiable, Decodable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let isPrivate: Bool
    public let htmlUrl: String
    
    public enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case isPrivate = "private"
        case htmlUrl = "html_url"
    }
}

public struct ContributionDay: Identifiable {
    public let id = UUID()
    public let count: Int
    public let level: Int
}
