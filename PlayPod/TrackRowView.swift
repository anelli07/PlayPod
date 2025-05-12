import SwiftUI
import AVFoundation

struct TrackRowView: View {
    let track: Track
    let isFavorite: Bool
    let isPlaying: Bool
    let togglePlay: () -> Void
    let toggleFavorite: () -> Void
    let openTrack: () -> Void

    var body: some View {
        Button(action: openTrack) {
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

                Spacer()

                Button(action: togglePlay) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .contentShape(Rectangle()) // 👈 делает всю область кликабельной
            .onTapGesture {
                openTrack()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
