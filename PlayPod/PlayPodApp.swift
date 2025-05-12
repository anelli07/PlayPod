
import SwiftUI

@main
struct PlayPodApp: App {
    @StateObject var audioManager = AudioPlayerManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
