//
//  VideoPlayerSwiftUI.swift
//  ARTrackerAlternate
//
//  Created by Ravi Rachamalla on 2021-02-23.
//

import SwiftUI
import AVKit
struct VideoPlayerSwiftUI: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "FallingDown-Live", withExtension: ".mp4")!))
    }
}

struct VideoPlayerSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerSwiftUI()
    }
}
