//
//  ContentView.swift
//  eidExample
//
//  Created by H-Solutions on 31/03/2024.
//

import SwiftUI
import 
import QKMRZParser
import QKMRZScanner
import UniformTypeIdentifiers
import Combine
import OSLog
import Vision
import UIKit
import AVFoundation
import Vision
//validateDataIDCard, scanBehindIdCard, scanChipIdCard, captureFace

struct ContentView: View {

    @State var mrz: String = ""
    @State var dataNFC: [String: String] = [:]
    @State private var showModal = false
    @State private var faceDetected = false
    private var eIDCheck = eIDCheckClient()

    var requests = [VNRequest]()

    mutating func setupVision() {
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: self.handleFaces)
        requests = [faceDetectionRequest]
    }

    func handleFaces(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNFaceObservation] else { return }

        // Xử lý kết quả phát hiện khuôn mặt
    }

    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                       // Hành động khi button được nhấp
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
                       // Nội dung hiển thị của button
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
                    // Nội dung hiển thị của button
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
                    // Nội dung hiển thị của button
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
                // Nội dung hiển thị của button
                Text("Scan Face")
                    .padding()
                    .background(Color.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $showModal) {
                
            }
            
            
            Spacer()
            
            
            Button(action: {
                print("Verify data")
                self.eIDCheck.validateDataIDCard { result in
                    switch result {
                    case .success(let message, let data):
                        Logger().debug("message: ==> \(message)")
                        print("Citizen ID Card: ==> ", data)
                        if let payload = data as? CitizenIdCard { // Kiểm tra kiểu và casting
                            print("Citizen ID Card payload:", payload)
                            // Xử lý dữ liệu payload ở đây
                        } else {
                            print("Dữ liệu không đúng định dạng mong muốn.")
                        }
                    case .failure(let message):
                        Logger().debug("message: ==> \(message)")
                    }
                }
                
            }) {
                // Nội dung hiển thị của button
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
