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
            } else {
                Image(systemName: "person.crop.artframe") // Placeholder
                    .resizable()
                    .frame(width: 50)
                    .aspectRatio(0.9,contentMode: .fit)
                    .foregroundStyle(Color.gray)
                    .opacity(0.8)
            }
        }
        .pipeline(pipeline)
    }
}

#Preview {
    AsyncLazyImageView(url: URL(string: "https://static.wikia.nocookie.net/naruto/images/d/d6/Naruto_Part_I.png")!)
}
