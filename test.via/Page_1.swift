//
//  Page_1.swift
//  test.via
//
//  Created by Sedat Yıldız on 26.06.2024.
//

import SwiftUI
import PhotosUI

struct Photo: Identifiable {
    let id = UUID()
    let imageName: String
    
}

let Fotolar = [
    Photo(imageName: "image"),
    Photo(imageName: "image"),
    Photo(imageName: "image"),
    Photo(imageName: "image"),
    Photo(imageName: "image"),
    Photo(imageName: "image"),
]

struct MainPageView: View {
    let photos: [Photo]

    var body: some View {
        VStack {
            HStack {
                Text("Ana Sayfa")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {
                    // profil butonuna action ekle
                }) {
                    Image(systemName: "person.fill")
                        .font(.title)
                }
                
                Text("Profil")
                    .fontWeight(.bold)
            }
            .padding()

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(photos) { photo in
                        Image(photo.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
                            .clipped()
                            .padding(.bottom, 30)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

struct FriendsView: View {
    var body: some View {
        Text("Aradasları burada göster")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}




struct CameraView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var image: UIImage?
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            // Arka plana gradient ekliyoruz
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Fotoğraf Seç ve Çek")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .padding()
                }
                
                Button(action: {
                    self.showCamera.toggle()
                }) {
                    Text("Kamerayı Aç")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .fullScreenCover(isPresented: self.$showCamera) {
                    AccessCameraView(selectedImage: self.$selectedImage)
                }
                
                PhotosPicker("Galeriden Seç", selection: $selectedItem, matching: .images)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            do {
                                if let data = try await newItem?.loadTransferable(type: Data.self) {
                                    image = UIImage(data: data)
                                }
                            } catch {
                                print("Failed to load the image: \(error)")
                            }
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .padding()
                }
            }
            .padding()
        }
    }
    
    struct AccessCameraView: UIViewControllerRepresentable {
        
        @Binding var selectedImage: UIImage?
        @Environment(\.presentationMode) var isPresented
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var parent: AccessCameraView
            
            init(_ parent: AccessCameraView) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let selectedImage = info[.originalImage] as? UIImage {
                    parent.selectedImage = selectedImage
                }
                parent.isPresented.wrappedValue.dismiss()
            }
        }
    }

    
    
}



struct MainContentView: View {
    var body: some View {
        TabView {
            MainPageView(photos: Fotolar)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }
            
            FriendsView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Arkadaslar")
                }
            
            CameraView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Fotoğraf")
                }
        }
    }
    
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
