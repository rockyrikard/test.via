//
//  ContentView.swift
//  test.via
//
//  Created by Zafer Aydın on 23.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View{
        
        ZStack{
            Image("image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .center, spacing: 1.0){
                    Spacer()
                    .frame(height: 450)
                TextField("Kullanici Adi", text: $username)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(0.7)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Şifre", text: $password)
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(0.7)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Button("Giriş") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .padding(.top, 23.0)
                
               
            }
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
