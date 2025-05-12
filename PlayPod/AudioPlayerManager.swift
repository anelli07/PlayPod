import SwiftUI
import AVFoundation

// Менеджер для управления музыки
class AudioPlayerManager: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?
    @Published var currentTrack: Track?
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 1

    private var timer: Timer?

    func startTracking() {
        stopTracking()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.audioPlayer else { return }
            self.currentTime = player.currentTime
            self.duration = player.duration
        }
    }

    func stopTracking() {
        timer?.invalidate()
        timer = nil
    }

    func togglePlayback(for track: Track) {
        // Если это тот же трек и он играет — ставим на паузу
        if currentTrack?.audioFileName == track.audioFileName && isPlaying {
            audioPlayer?.pause()
            isPlaying = false
            stopTracking()
        } else {
            // Если новый трек — загружаем его
            if currentTrack?.audioFileName != track.audioFileName {
                if let url = Bundle.main.url(forResource: track.audioFileName, withExtension: "mp3") {
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        currentTrack = track
                        audioPlayer?.prepareToPlay()
                        audioPlayer?.play()
                        isPlaying = true
                        startTracking()
                    } catch {
                        print("Ошибка воспроизведения: \(error.localizedDescription)")
                    }
                }
            } else {
                // Тот же трек, но был на паузе — продолжим
                audioPlayer?.play()
                isPlaying = true
                startTracking()
            }
        }
    }

    func playNext(from tracks: [Track]) {
        guard let current = currentTrack,
              let index = tracks.firstIndex(where: { $0.id == current.id }) else { return }

        let nextIndex = (index + 1) % tracks.count
        togglePlayback(for: tracks[nextIndex])
    }
}
