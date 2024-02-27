# eIDCheck-SDK

Link tải thư viện tại CoacaPods: [eIDCheckSDK](https://cocoapods.org/pods/eIDCheckSDK)

**Cài đặt SDK:**   
  `pod 'eIDCheckSDK'`

Phiên bản iOS yêu cầu: **>= iOS 14.0**


**1. Cấu hình**
   * **Cấu hình Identifier**:
     - Trong **Identifier** của dự án, tích chọn vào các quyền sau:
       
          ![Alt text](/image/identifier_2.png)
       
       ![Alt text](/image/identifier_1.png)

   * Cấu hình **XCODE**:
     - Thêm **Capability** mới trong dự án
       
        ![Alt text](/image/config_1.png)

     - Khai báo các thông tin sau trong tệp **Info.plit**:

       ![Alt text](/image/config_2.png)
       
   * **Thêm chứng chỉ vào dự án**:
     - Các bước tạo cấu hình chứng chỉ tại: [Hướng dẫn tạo chứng chỉ](/scripts/README.md)
     - Kết quả
       
          ![Alt text](/image/config_3.png)

  **2.Các functionc chức năng**

      - import eIDCheckSDK vào dự án của bạn.
      
      - func login(username: String, password: String, completionHandler: @escaping ([String: Any]) -> Void)
         + username, password: được cung cấp bởi Sale
         + completionHandler: là callback của func sau khi login thành công.
             Các trường dữ liệu trả về:
                + code_error: mã lỗi
                + message: chú thích của action
                + code: trạng thái login, với 000 là thành công.
                
      - func scanMRZ(completionHandler: @escaping ([String: Any]) -> Void)
         + fnc này để scan key MRZ trên CCCD.
         + completionHandler: là callback của func sau khi scan thành công.
          Các trường dữ liệu trả về:
                + mrzKey: là key mrz đọc được từ CCCD.

      - func parseMRZkey(cccdNumber: String, dateOfBirth: Date, dateOfExpiry: Date , completionHandler: @escaping ([String: Any]) -> Void)
        + Ngoài việc scan mặt sau của CCCD để lấy MRZKEY, bạn cũng có thể sử dụng fnc này để nhập MRZKey của user.
        + cccdNumber: 9 số cuối của CCCD 
        + dateOfBirth: Ngày sinh trên CCCD
        + dateOfExpiry: Ngày hết hạn trên CCCD
        + completionHandler: là callback của func sau khi parseMRZkey thành công.
           Các trường dữ liệu trả về:
                + code_error: mã lỗi
                + message: chú thích của action
                + code: trạng thái login, với 000 là thành công.

      - func scanNFC(mrzKey: String, completionHandler: @escaping ([String: String]) -> Void) 
        + Func này dùng để scan NFC trên CCCD với mrzKey là bắt buộc
        + completionHandler: là callback của func sau khi scanNFC thành công, 
            Các trường dữ liệu trả về sau khi scan thành công:
                + code_error: mã lỗi
                + message: chú thích của action
                + code: trạng thái login, với 000 là thành công.
                + cccdImage:  String - base64
                + DG1: String
                + DG2: String
                + SOD: String
                + COM: String
                + DG13: String
                + DG14: String
                + DG15: String

    - func verifyData(data: [String: String], completionHandler: @escaping ([String: Any]) -> Void)
      + Func này thực hiện xác thực dữ liệu với hệ thống
      + Các tham số yêu cầu:
                + DG1: String
                + DG2: String
                + SOD: String
                + COM: String
                + DG13: String
                + DG14: String
                + DG15: String
                + centerImage: Base64 // ảnh chụp chính giữa khuôn mặt
                + skipCaching: Bool // true cho production
      + completionHandler: func trả về kết qủa sau khi xác thực thành công, dữ liệu dạng JSON
      

      
  **3.Các mã lỗi**
  
  | Code | Mô tả |
|---|---|
| 000 | Thành công |
| 100 | Lỗi reponse (chi tiết message kèm theo) |
| 101 | Lỗi format data từ API (chi tiết message kèm theo) |
| 104 | Lỗi sai number CCCD (chi tiết message kèm theo) |
| 106 | Lỗi Scan NFC, vui lòng scan lại |
| 107 | Chưa login vào hệ thống |
| 109 | Thiếu các field yêu cầu (chi tiết message kèm theo)  |


   
    
       
       
