import Foundation

// Модель трека
struct Track: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let artist: String
    let genre: String
    let coverImageName: String
    let audioFileName: String
}
