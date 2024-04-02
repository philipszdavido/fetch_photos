//
//  ViewImageView.swift
//  fetch_photos
//
//  Created by Chidume Nnamdi on 4/3/24.
//

import SwiftUI

struct ViewImageView: View {
    
    @Binding var photo: Photo?
    
    var body: some View {
        
        if let nonNilPhoto = photo {
            HStack {
                
                Text("View Image")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                
                Spacer()
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .onTapGesture(perform: {
                        photo = nil
                    })
                
            }.padding(.leading)
            
            AsyncImage(url: URL(string: nonNilPhoto.url))
            Text(nonNilPhoto.title)
        }
    }
}

#Preview {
    ViewImageView(photo: .constant(Photo(id: 0, title: "", url: "", thumbnailUrl: "")))
}
