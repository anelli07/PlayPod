
import SwiftUI

struct ContentView: View {
    let tracks = MockData.tracks
    
    @State private var selectedTrack: Track? = nil
    @State private var showFavorites = false
    @State private var showPlayerSheet = false
    @AppStorage("favoriteTrackIDs") private var favoriteTrackIDsData: Data = Data()
    @State private var favoriteTrackIDs: Set<UUID> = []
    
    @EnvironmentObject var audioManager: AudioPlayerManager

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                List {
                    // Треки
                    Section(header: Text("Tracks").font(.title2).bold()) {
                        ForEach(tracks) { track in
                            Button(action: {
                                selectedTrack = track
                            }) {
                                TrackRowView(
                                    track: track,
                                    isFavorite: favoriteTrackIDs.contains(track.id),
                                    isPlaying: audioManager.currentTrack?.audioFileName == track.audioFileName && audioManager.isPlaying,
                                    togglePlay: { audioManager.togglePlayback(for: track) },
                                    toggleFavorite: { toggleFavorite(for: track) },
                                    openTrack: { selectedTrack = track }
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }

                    // Альбом
                    Section(header: Text("Albums").font(.title2).bold()) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(MockData.albums) { album in
                                    NavigationLink(destination: AlbumView(album: album)) {
                                        VStack {
                                            Image(album.coverImageName)
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .cornerRadius(12)
                                            Text(album.title)
                                                .font(.caption)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .listRowInsets(EdgeInsets())
                    }
                }

                // Мини плейер дорожка
                if let current = audioManager.currentTrack {
                    MiniPlayerView(
                        track: current,
                        isPlaying: audioManager.isPlaying,
                        togglePlay: {
                            audioManager.togglePlayback(for: current)
                        },
                        playNext: {
                            audioManager.playNext(from: tracks)
                        }
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                    .onTapGesture {
                        showPlayerSheet = true
                    }
                    .sheet(isPresented: $showPlayerSheet) {
                        PlayerView(track: current, autoPlay: false)
                            .environmentObject(audioManager)
                    }
                }
            }

            .navigationTitle("PlayPod")

            .navigationDestination(item: $selectedTrack) { track in
                PlayerView(track: track, autoPlay: true)
                    .environmentObject(audioManager)
            }

            .toolbar {
                Button(action: {
                    showFavorites = true
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }

            .sheet(isPresented: $showFavorites) {
                FavoritesView(tracks: tracks, favoriteIDs: $favoriteTrackIDs)
            }

            .onAppear {
                loadFavorites()
            }
        }
    }

    // Избранное
    func toggleFavorite(for track: Track) {
        if favoriteTrackIDs.contains(track.id) {
            favoriteTrackIDs.remove(track.id)
        } else {
            favoriteTrackIDs.insert(track.id)
        }
        saveFavorites()
    }

    func saveFavorites() {
        if let data = try? JSONEncoder().encode(Array(favoriteTrackIDs)) {
            favoriteTrackIDsData = data
        }
    }

    func loadFavorites() {
        if let ids = try? JSONDecoder().decode([UUID].self, from: favoriteTrackIDsData) {
            favoriteTrackIDs = Set(ids)
        }
    }
}

#Preview {
    ContentView().environmentObject(AudioPlayerManager())
}
