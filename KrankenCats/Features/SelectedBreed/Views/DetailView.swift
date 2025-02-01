//
//  DetailView.swift
//  KrankenCats
//
//  Created by Philip Igboba on 01/02/2025.
//

import SwiftUI

struct DetailView: View {

    @StateObject var vm:  SelectedBreedViewModel
   
    
    var body: some View {
        ZStack {
            background
            
            if vm.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading,
                           spacing: 8) {
                        avatar
                        Group {
                            general  .padding(.horizontal, 8)
                                .padding(.vertical, 18)
                                .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                                         style: .continuous))
                            link .padding(.horizontal, 8)
                                .padding(.vertical, 18)
                                .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                                          style: .continuous))
                        }
                      
    
                    }
                      .padding()
                }
            }
        }
       
    }
}


private extension DetailView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    var avatar: some View {
        
        if let avatarAbsoluteString = vm.selectedBreedImageResponse?.breedImages[0].url,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16,
                                        style: .continuous))
            
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = vm.selectedBreed?.cfaURL,
           let supportUrl = URL(string: supportAbsoluteString)
         {
            HStack{
                VStack(alignment: .leading,
                       spacing: 2) {
                    
                    Text("CFA")
                        .foregroundColor(Theme.text)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                        .multilineTextAlignment(.leading)
                    
                    Text(supportAbsoluteString).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).onTapGesture {
                        UIApplication.shared.open(supportUrl)
                    }
                }
                
                
            }
            
        }
    }
}

private extension DetailView {
    
    var general: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            Group {
                name
                description
                country
            }

        }
    }
    
    @ViewBuilder
    var name: some View {
        Text("Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.selectedBreed?.name ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var description: some View {
        Text("Description")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.selectedBreed?.description ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var country: some View {
        Text("Country")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.selectedBreed?.countryCodes ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}

