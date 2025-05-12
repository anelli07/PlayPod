import SwiftUI

struct MiniPlayerView: View {
    let track: Track
    let isPlaying: Bool
    let togglePlay: () -> Void
    let playNext: () -> Void

    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
                .shadow(radius: 4)

            HStack(spacing: 12) {
                Image(track.coverImageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)

                VStack(alignment: .leading) {
                    Text(track.title)
                        .font(.headline)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(track.artist)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }

                Spacer()

                Button(action: togglePlay) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }

                Button(action: playNext) {
                    Image(systemName: "forward.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .frame(height: 70)
    }
}
