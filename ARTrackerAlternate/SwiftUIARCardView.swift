//
//  SwiftUIARCardView.swift
//  ARTrackerAlternate
//
//  Created by Ravi Rachamalla on 2021-02-23.
//

import SwiftUI
import AVKit

struct SwiftUIARCardView: View {
    // setting up a state variable to hold the value of the displayed message on screen
    @State private var headerText = "Oasis Falling Down AR Experience"
    
    var body: some View {
        // set up a basic bacground ui with a Zstack
        // Zstacks will position elements on top of each other
        // in a 3dimensional way
        ZStack{
            // Rouded rectangle with a gradient as our background
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .edgesIgnoringSafeArea(.all)
            // Vstack will position the elements inside vertically
            // on top of each other
            VStack {
                // create a text element that will display the header text
                // with a title font and a bold font weight
                Text(headerText).foregroundColor(.white).bold().font(.title)
                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "FallingDown-Live", withExtension: "mp4")!)).scaledToFill()
//                VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=PJMOTbaVh44")!)).scaledToFill()
            }
            
        }
    }
}

struct SwiftUIARCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIARCardView()
    }
}
