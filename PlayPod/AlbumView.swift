import SwiftUI

// Показывает треки внутри альбома
struct AlbumView: View {
    let album: Album

    var body: some View {
        List(album.tracks) { track in
            NavigationLink(destination: PlayerView(track: track)) {
                HStack {
                    Image(track.coverImageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(track.title).font(.headline)
                        Text(track.artist).font(.subheadline).foregroundColor(.gray)
                        Text(track.genre).font(.caption).foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle(album.title)
    }
}

#Preview {
    AlbumView(album: MockData.albums[0])
}
