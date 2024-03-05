//
//  ImageView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import SwiftUI
import Combine

struct HabitImageView: View {
    
    @State var image: UIImage = UIImage()
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(
                imageLoader.didChange,
                perform: { data in
                    self.image = UIImage(data: data) ?? UIImage()
                }
            )
    }
}

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
    
}

struct HabitImageView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            HabitImageView(url: "https://static.significados.com.br/foto/hqdefault_sm.jpg")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme(colorScheme)
        }
    }
}
