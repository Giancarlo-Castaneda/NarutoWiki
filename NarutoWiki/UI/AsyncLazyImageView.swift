import Nuke
import NukeUI
import SwiftUI

struct AsyncLazyImageView: View {

    let url: URL
    private let pipeline = ImagePipeline {
        $0.dataLoader = {
            let config = URLSessionConfiguration.default
            config.urlCache = nil
            return DataLoader(configuration: config)
        }()
    }

    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if state.isLoading {
                ProgressView()
            } else {
                Color.gray.opacity(0.2)
            }
        }
        .pipeline(pipeline)
    }
}

#Preview {
    AsyncLazyImageView(url: URL(string: "https://static.wikia.nocookie.net/naruto/images/d/d6/Naruto_Part_I.png")!)
}
