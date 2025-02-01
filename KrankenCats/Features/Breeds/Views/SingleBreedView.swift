//
//  SingleBreedView.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//


import SwiftUI

struct SingleBreedView: View {
    
    let breed: Breed
    
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: .init(string: breed.image?.url ?? "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                
                CatNumberView(id: Int(breed.id) ?? 0)  
                
                Text("\(breed.name) \nWeight:\(breed.weight.metric)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                    )
            }
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background()

            
        }
        .clipShape(RoundedRectangle(cornerRadius: 16,
                                    style: .continuous))
        .shadow(
                radius: 2,
                x: 0,
                y: 1)
    }
}

struct SingleBreedView_Previews: PreviewProvider {
    
    static var previewBreed:  Breed {
    let breeds = try! StaticJSONMapper.decode(file: "breeds", type: [Breed].self);
    let breedsResponse =  BreedsResponse(breeds: breeds)
        return breedsResponse.breeds.first!
    }
    
    static var previews: some View {
        SingleBreedView(breed: previewBreed)
            .frame(width: 250)
    }
}
