//
//  mainpage.swift
//  test.via
//
//  Created by Zafer Aydın on 23.06.2024.
//

import SwiftUI
import FirebaseDatabase

struct mainpage: View {
    
    @State private var NewConfirmpassword: String = ""
    @State private var Newusername: String = ""
    @State private var Newpassword: String = ""
    @State private var Newname: String = ""
    @State private var Newsurname: String = ""
    @State private var errorMessage: String = ""
   
    
    
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
                        
                        SecureField("Sifre Tekrar", text: $NewConfirmpassword)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        if !errorMessage.isEmpty {
                                        Text(errorMessage)
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                        HStack(){
                            
                            Button(action: {
                                registerUser()
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
    
    func registerUser() {
            // Kayıt işlemini başlat
            if Newpassword != NewConfirmpassword {
                errorMessage = "Şifreler uyuşmuyor"
            } else {
                // Firebase'e kullanıcı adı ve şifreyi kaydet
                let ref = Database.database().reference()
                let userRef = ref.child("users").childByAutoId()
                let userObject = [
                    "username": Newusername,
                    "password": Newpassword,
                    "name": Newname,
                    "surname":Newsurname,
                    
                ]

                userRef.setValue(userObject) { (error, ref) in
                    if let error = error {
                        errorMessage = "Kayıt başarısız: \(error.localizedDescription)"
                    } else {
                        errorMessage = "Kayıt başarılı"
                    }
                }
            }
        }

    
    
    
    
    
}




#Preview {
    mainpage()
}
