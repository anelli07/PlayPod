import Foundation

// Данные для треков и альбомов
struct MockData {
    static let tracks: [Track] = [
        Track(title: "Moonlight", artist: "Aliya", genre: "Pop", coverImageName: "cover1", audioFileName: "moonlight"),
        Track(title: "City Lights", artist: "Neo", genre: "Electronic", coverImageName: "cover2", audioFileName: "citylights"),
        Track(title: "Waves", artist: "Lena", genre: "Chill", coverImageName: "cover3", audioFileName: "waves")
    ]
    
    static let albums: [Album] = [
        Album(title: "Dreamscape", artist: "Aliya", coverImageName: "cover1", tracks: [
            tracks[0], tracks[2]
        ]),
        Album(title: "Night Pulse", artist: "Neo", coverImageName: "cover2", tracks: [
            tracks[1]
        ])
    ]
}
