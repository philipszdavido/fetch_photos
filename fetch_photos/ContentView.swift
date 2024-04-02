//
//  ContentView.swift
//  fetch_photos
//
//  Created by Chidume Nnamdi on 4/2/24.
//

import SwiftUI

struct Photo: Codable, Identifiable {
    var id: Int;
    var title: String;
    var url: String;
    var thumbnailUrl: String;
}

struct ContentView: View {
    
    @State private var photos: [Photo]?
    @State private var selectedPhoto: Photo?
    
    func fetchPhotos() async throws -> [Photo] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos");
        
        let (data, _) = try await URLSession.shared.data(from: url!);
        
        let decodedResponse = try JSONDecoder().decode([Photo].self, from: data);
        
        return decodedResponse;
    }
    
    var body: some View {
        if(selectedPhoto != nil) {
            
            ViewImageView(photo: $selectedPhoto)
                .animation(.spring)
            
        } else {
        NavigationView {
            
            if(photos != nil) {
                List(photos!) { photo in
                    
                    AsyncImage(url: URL(string: photo.thumbnailUrl)) { image in image.resizable()
                            .onTapGesture(perform: {
                                
                                selectedPhoto = photo;
                            } )
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    
                    Text(photo.title)
                    
                }.navigationTitle("Photos")
            }
            
        }.onAppear {
            Task {
                photos = try await fetchPhotos()
            }
        }
    }
    }
}

#Preview {
    ContentView()
}
