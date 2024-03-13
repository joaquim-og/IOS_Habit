//
//  ImagePickerView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(
            image: $image,
            imageData: $imageData,
            isPresented: $isPresented
        )
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = sourceType
        }
        
        pickerController.delegate = context.coordinator
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

class ImagePickerViewCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    init(
        image: Binding<Image?>,
        imageData: Binding<Data?>,
        isPresented: Binding<Bool>
    ) {
        self._image = image
        self._imageData = imageData
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = Image(uiImage: image)
            self.imageData = image.jpegData(compressionQuality: 0.5)
        }
        
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isPresented = false
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    @State static var image: Image? = nil
    @State static var imageData: Data? = nil
    @State static var isPresented = true

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ImagePickerView(
                image: $image,
                imageData: $imageData,
                isPresented: $isPresented,
                sourceType: .photoLibrary
            )
            .frame(maxWidth: .infinity, maxHeight: 350)
            .preferredColorScheme($0)
        }
    }
}
