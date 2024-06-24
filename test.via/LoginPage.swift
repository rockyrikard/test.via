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
        
        NavigationView{
            ZStack{
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center, spacing: 1.0){
                    
                    Spacer()
                        .frame(height: 450)
                    TextField("Kullanici Adi", text: $username)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .opacity(0.7)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Şifre", text: $password)
                        .multilineTextAlignment(.center)
                        .padding()
                        .opacity(0.7)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack(){
                        
                        Button(action: {
                        }) {
                            NavigationLink(destination: mainpage()){
                                Text("Kayıt Ol")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .frame(width: 100)
                                    .background(Color.gray.opacity(0.8))
                                    .cornerRadius(30)
                            }
                        }
                        
                        //Spacer()
                        
                        
                        Button(action: {
                        }) {
                            
                                Text("Giriş")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .frame(width: 100)
                                    .background(Color.gray.opacity(0.8))
                                    .cornerRadius(30)
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
