import SwiftUI

struct FavoritesView: View {
    let tracks: [Track]
    @Binding var favoriteIDs: Set<UUID>
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audioManager: AudioPlayerManager

    var body: some View {
        let favoriteTracks = tracks.filter { favoriteIDs.contains($0.id) }

        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
            }

            if favoriteTracks.isEmpty {
                Spacer()
                VStack(spacing: 20) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("У вас пока нет избранных треков")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                List {
                    ForEach(favoriteTracks) { track in
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

                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    StatefulPreviewWrapper(Set([MockData.tracks[0].id])) { binding in
        FavoritesView(tracks: MockData.tracks, favoriteIDs: binding)
            .environmentObject(AudioPlayerManager())
    }
}

struct StatefulPreviewWrapper<Value>: View {
    @State var value: Value
    var content: (Binding<Value>) -> AnyView

    init(_ value: Value, content: @escaping (Binding<Value>) -> some View) {
        self._value = State(initialValue: value)
        self.content = { binding in AnyView(content(binding)) }
    }

    var body: some View {
        content($value)
    }
}
