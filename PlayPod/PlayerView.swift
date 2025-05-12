
import SwiftUI
import AVFoundation

struct PlayerView: View {
    let track: Track
    var autoPlay: Bool = true

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audioManager: AudioPlayerManager

    var body: some View {
        VStack(spacing: 30) {
            // Кнопка назад
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }

            Image(track.coverImageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(16)
                .padding()

            Text(track.title)
                .font(.title)
                .bold()

            Text(track.artist)
                .font(.title3)
                .foregroundColor(.gray)

            // Временная шкала
            VStack {
                Slider(value: Binding(
                    get: { audioManager.currentTime },
                    set: { newValue in
                        audioManager.audioPlayer?.currentTime = newValue
                        audioManager.currentTime = newValue
                    }
                ), in: 0...audioManager.duration)

                HStack {
                    Text(formatTime(audioManager.currentTime))
                    Spacer()
                    Text(formatTime(audioManager.duration))
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.horizontal)

            // Play/Pause
            Button(action: {
                audioManager.togglePlayback(for: track)
            }) {
                Image(systemName: audioManager.isPlaying && audioManager.currentTrack?.id == track.id
                      ? "pause.circle.fill"
                      : "play.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            if autoPlay {
                audioManager.togglePlayback(for: track)
            }
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    PlayerView(track: MockData.tracks[0])
        .environmentObject(AudioPlayerManager())
}
