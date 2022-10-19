import UIKit
import AVFoundation

public class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    internal var player: AVAudioPlayer!

    var filename: String!

    public init?(_ name: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Couldn't set up AVAudioSession")
        }

        super.init()

        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            print("Could not retrieve url for \(name)")
            return nil
        }

        guard let player = try? AVAudioPlayer(contentsOf: url) else {
            print("Could not create player from contents of : \(url)")
            return nil
        }

        self.player = player
        player.delegate = self
        self.filename = name
    }

    public convenience init?(copy original: AudioPlayer) {
        self.init(original.filename)
    }

    public func play() {
        player.play()
    }

    public func pause() {
        player.pause()
    }

    public func stop() {
        player.stop()
    }

    public var duration: Double {
        get {
            return Double(player.duration)
        }
    }

    public var playing: Bool {
        get {
            return player.isPlaying
        }
    }

    public var pan: Double {
        get {
            return Double(player.pan)
        } set(val) {
            player.pan = min(max(Float(val), -1), 1)
        }
    }

    public var volume: Double {
        get {
            return Double(player.volume)
        } set(val) {
            player.volume = Float(val)
        }
    }

    public var currentTime: Double {
        get {
            return player.currentTime
        } set(val) {
            player.currentTime = TimeInterval(val)
        }
    }

    public var rate: Double {
        get {
            return Double(player.rate)
        } set(val) {
            player.rate = Float(val)
        }
    }

    public var loops: Bool {
        get {
            return player.numberOfLoops > 0 ? true : false
        }
        set(val) {
            if val {
                player.numberOfLoops = 1000000
            } else {
                player.numberOfLoops = 0
            }
        }
    }

    public var meteringEnabled: Bool {
        get {
            return player.isMeteringEnabled
        } set(v) {
            player.isMeteringEnabled = v
        }
    }

    public var enableRate: Bool {
        get {
            return player.enableRate
        } set(v) {
            player.enableRate = v
        }
    }

    public func updateMeters() {
        player.updateMeters()
    }

    public func averagePower(channel: Int) -> Double {
        return Double(player.averagePower(forChannel: channel))
    }

    public func peakPower(channel: Int) -> Double {
        return Double(player.peakPower(forChannel: channel))
    }
}
