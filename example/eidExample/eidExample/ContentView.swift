//
//  ContentView.swift
//  eidExample
//
//  Created by H-Solutions on 31/03/2024.
//

import SwiftUI
import eIDCheckSDK
import OSLog



struct ContentView: View {
    private var eIDCheck = eIDCheckClient()

    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.eIDCheck.login(username: "0967884005", password: "12345678") { data in
                    switch data {
                    case .success(let message, let data):
                        Logger().debug("message: ==> \(message)")
                        if let data = data as? UserEidCheckInfo {
                            print("Login user ====> ")
                            print(data)
                        } else {
                            Logger().debug("Lỗi: Dữ liệu không đúng định dạng hoặc nil")
                        }
                    case .failure(message: let message):
                        Logger().debug("message: ==> \(message)")
                    }
                }
    
                   }) {
                       Text("Login")
                           .padding()
                           .background(Color.pink)
                           .foregroundColor(.white)
                           .cornerRadius(8)
                   }
            
            Spacer()
            HStack(){
                Button(action: {
                    self.eIDCheck.scanBehindIdCard  { result in
                        switch result {
                        case .success(let message, let data):
                            Logger().debug("message: ==> \(message)")
                        case .failure(let message):
                            Logger().debug("message: ==> \(message)")
                        }

                    }

                }) {
                    Text("Scan MRZ!")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                
                Button(action: {
                    print("Button was tapped")
                    self.eIDCheck.scanChipIdCard { result in
                        switch result {
                        case .success(let message, let data):
                            Logger().debug("message: ==> \(message)")
                        case .failure(let message):
                            Logger().debug("message: ==> \(message)")
                        }
                    }
                }) {
                    Text("Read CCCD!")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            Button(action: {
                self.eIDCheck.captureFace {  result in
                    switch result {
                    case .success(let message, let data):
                        Logger().debug("message: ==> \(message)")
                    case .failure(let message):
                        Logger().debug("message: ==> \(message)")
                    }
                }
            }) {
          
                Text("Scan Face")
                    .padding()
                    .background(Color.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            
            Spacer()
            
            
            Button(action: {
                print("Verify data")
                self.eIDCheck.validateDataIDCard { result in
                    switch result {
                    case .success(let message, let data):
                        Logger().debug("message: ==> \(message)")
                        print("Citizen ID Card: ==> ", data)
                        if let payload = data as? CitizenIdCard {
                            print("Citizen ID Card payload:", payload)
                    
                        } else {
                            print("Dữ liệu không đúng định dạng mong muốn.")
                        }
                    case .failure(let message):
                        Logger().debug("message: ==> \(message)")
                    }
                }
                
            }) {
               
                Text("Verify NFC!")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
            Button(action: {
                print("Verify data")
                self.eIDCheck.logOut()
                
            }) {
                // Nội dung hiển thị của button
                Text("Log OUT")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
