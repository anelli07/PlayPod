import Foundation

// Модель для альбома
struct Album: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let coverImageName: String
    let tracks: [Track]
}
