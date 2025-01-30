//
//  SingleBreedImageView.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import SwiftUI

struct SingleBreedImageView: View {
    
    let breedImage: BreedImage
   
    
    var body: some View {
        VStack(spacing: .zero) {
            
            AsyncImage(url: .init(string: breedImage.url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16,
                                    style: .continuous))
        .shadow(
                radius: 2,
                x: 0,
                y: 1)
    }
}


    struct SingleBreedImageView_Previews: PreviewProvider {
        
        static var previewBreedImage:  BreedImage {
        let breedImages = try! StaticJSONMapper.decode(file:  "selected_breed", type: [BreedImage].self);
        let breedsResponse =  SelectedBreedImageResponse(breedImages: breedImages)
            return breedsResponse.breedImages.first!
        }
        
        static var previews: some View {
            SingleBreedImageView(breedImage: previewBreedImage)
                .frame(width: 250)
        }
    }


