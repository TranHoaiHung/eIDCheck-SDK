# eIDCheck-SDK

Link tải thư viện tại CoacaPods: [eIDCheckSDK](https://cocoapods.org/pods/eIDCheckSDK)

**Cài đặt SDK:**   
  `pod 'eIDCheckSDK'`

Phiên bản iOS yêu cầu: **>= iOS 14.0**


## 1. Cấu hình
   * **Cấu hình Identifier**:
     - Trong **Identifier** của dự án, tích chọn vào các quyền sau:
       
          ![Alt text](/image/identifier_2.png)
       
       ![Alt text](/image/identifier_1.png)

   * Cấu hình **XCODE**:
     - Thêm **Capability** mới trong dự án
       
        ![Alt text](/image/config_1.png)

     - Khai báo các thông tin sau trong tệp **Info.plit**:

       ![Alt text](/image/config_2.png)

       Các giá trị khai báo trong tệp **Info.plit**:
      ```xml
      <dict>
          <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
          <array>
              <string>A0000002471001</string>
              <string>A0000002472001</string>
              <string>00000000000000</string>
          </array>
      </dict>
      ```

       
   * **Cấu hình run debug**:
     - Đặt giá trị của **User Script Sandboxing:  No**
     - Kết quả
       
          ![Alt text](/image/setup_1.png)

 ## 2. Chức năng
 [Source Demo](example/eidExample)
```swift
import eIDCheckSDK // import SDK vào dự án của bạn

private var eIDCheck = eIDCheckClient() // khởi tạo SDK 

// Gọi func login để login vào hệ thống. Thống tin đăng nhập vui kết nối với sales
 self.eIDCheck.login(username: "Phone or Mail", password: "your_password") { data in
                    switch data {
                    case .success(let message, let data):
                          // dữ liệu trả về sau khi login thành công:
                        if let data = data as? UserEidCheckInfo {
                          // Object UserEidCheckInfo chứa thông tin của user đươc trả về từ hệ thống.
                            print(data)
                        } 
                    case .failure(message: let message):
                        // dữ liệu trả về sau khi login thất bại, kèm thông tin trong message
                        print(message)
                    }
                }

// Gọi func dùng để logout khỏi hệ thống
 self.eIDCheck.logOut()

// Gọi func để đọc dữ liệu MRZ(mặt sau của CCCD)         
self.eIDCheck.scanBehindIdCard  { result in
                        switch result {
                        case .success(let message):
                            // Thông tin 
                            print("message: ==> \(message)")
                        case .failure(let message):
                            print("message: ==> \(message)")
                        }
                    }

// Gọi func để bắt đầu đọc dữ liệu NFC trên CCCD
 self.eIDCheck.scanChipIdCard { result in
                        switch result {
                        case .success(let message, _):
                            print("message: ==> \(message)")
                        case .failure(let message):
                             print("message: ==> \(message)")
                        }
                    }

// Gọi func để bắt đầu chụp hình khuôn mặt của bạn
 self.eIDCheck.captureFace {  result in
                    switch result {
                    case .success(let message, let data):
                        // data dạng String, ảnh khuôn mặt sau khi hệ thống tự nhận diện từ ảnh bạn chụp
                        print("message: ==> \(message)")
                    case .failure(let message):
                        print("message: ==> \(message)")
                    }
                }

// Gọi func để bắt đầu xác nhận dữ liệu với hệ thống
self.eIDCheck.validateDataIDCard { result in
                    switch result {
                    case .success(let message, let data):
                         print("message: ==> \(message)")
                        // Thông tin dữ liệu sau khi đọc được từ CCCD và đã xác minh với hệ thống
                        if let payload = data as? CitizenIdCard {
                            print("Citizen ID Card payload:", payload)
                        } 
                    case .failure(let message):
                         print("message: ==> \(message)")
                    }
                }

```
      
## 3.Hình ảnh minh hoạ UI của SDK

  - **Hình ảnh UI của SDK khi gọi func scanBehindIdCard:**
    
    ![Alt text](/image/scanBehindIdCard.jpeg)

    
  - **Hình ảnh UI của SDK khi gọi func scanChipIdCard:**
    
    ![Alt text](/image/scanChipIdCard.jpeg)
    


  - **Hình ảnh UI của SDK khi gọi func captureFace:**
    
    ![Alt text](/image/captureFace.jpeg) 
   
    
       
       
