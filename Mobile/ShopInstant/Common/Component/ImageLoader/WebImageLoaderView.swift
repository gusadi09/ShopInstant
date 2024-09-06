//
//  WebImageLoaderView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 04/09/24.
//

import SwiftUI

struct WebImageLoaderView: View {
    let url: String?
    let width: CGFloat?
    let height: CGFloat?
    let aspectRatio: ContentMode
    
    init(url: String?, width: CGFloat? = nil, height: CGFloat? = nil, aspectRatio: ContentMode) {
        self.url = url
        self.width = width
        self.height = height
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: aspectRatio)
                    .frame(width: width, height: height)
            case .failure(_):
                Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                    .foregroundColor(.white)
                    .frame(width: width, height: height)
                
            @unknown default:
                ProgressView()
                    .frame(width: width, height: height)
            }
        }
    }
}

#Preview {
    WebImageLoaderView(url: "gt", aspectRatio: .fill)
        .frame(width: 100, height: 100)
        .background(Rectangle().foregroundColor(.gray))
        .clipShape(Circle())
}
