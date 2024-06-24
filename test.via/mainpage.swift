//
//  mainpage.swift
//  test.via
//
//  Created by Zafer Aydın on 23.06.2024.
//

import SwiftUI

struct mainpage: View {
    @State private var Newusername: String = ""
    @State private var Newpassword: String = ""
    @State private var Newname: String = ""
    @State private var Newsurname: String = ""
    
    var body: some View {
        
        
            
            NavigationView{
                ZStack{
                    Image("image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .center, spacing: 1.0){
                        
                        Spacer()
                            .frame(height: 50)
                        TextField("İsim", text: $Newname)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Soyisim", text: $Newsurname)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Kullanici Adi", text: $Newusername)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Sifre", text: $Newpassword)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Sifre Tekrar", text: $Newpassword)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack(){
                            
                            Button(action: {
                            }) {
                                
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
                }
            }
        }
    }
}

#Preview {
    mainpage()
}
