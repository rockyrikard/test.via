//
//  mainpage.swift
//  test.via
//
//  Created by Zafer Aydın on 23.06.2024.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct mainpage: View {
    
    @State private var Confirmpassword: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var username: String = ""
    @State private var errorMessage: String = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
  
    
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
                        TextField("İsim", text: $name)
                            //.foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Soyisim", text: $surname)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("E-mail", text: $email)
                            //.foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Kullanıcı Adı", text: $username)
                            //.foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Sifre", text: $password)
                           // .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Sifre Tekrar", text: $Confirmpassword)
                           //.foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .opacity(0.7)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        if !errorMessage.isEmpty {
                                        Text(errorMessage)
                                            .foregroundColor(.white)
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
                            .padding()
                            .alert(isPresented: $showingAlert) {
                                        Alert(title: Text("Kayıt Hatası"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                    }
                    }
                }
            }
        }
    }
    func registerUser() {
            if password != Confirmpassword {
                errorMessage = "Şifreler uyuşmuyor."
                return
            }
        
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    errorMessage = "Kayıt Hatası: \(error.localizedDescription)"
                    return
                }
                
                guard let uid = authResult?.user.uid else {
                    errorMessage = "Kullanıcı ID alınamadı."
                    return
                }
                
                let ref = Database.database().reference()
                let userReference = ref.child("users").child(uid)
                let values = ["name": name, "surname": surname, "username": username]
                
                userReference.updateChildValues(values) { error, ref in
                    if let error = error {
                        errorMessage = "Veritabanı Hatası: \(error.localizedDescription)"
                        return
                    }
                    
                    alertMessage = "Kayıt Başarılı!"
                    showingAlert = true
                    clearFields()
                }
            }
        }
    
    func clearFields() {
            name = ""
            surname = ""
            username = ""
            email = ""
            password = ""
            Confirmpassword = ""
            errorMessage = ""
        }
    
    
    
   /*
    func registerUser() {
        
       if password != Confirmpassword {
                   alertMessage = "Passwords do not match."
                   showingAlert = true
                   return
               }
               
               Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                   if let error = error {
                       alertMessage = "Registration Error: \(error.localizedDescription)"
                       showingAlert = true
                       return
                   }
                   alertMessage = "Registration Successful!"
                   showingAlert = true
               }
       
       
        
        
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
        */
        }

    
    
    
    
    





#Preview {
    mainpage()
}
