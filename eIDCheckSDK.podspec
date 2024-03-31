Pod::Spec.new do |spec|
    spec.name         = "eIDCheckSDK"
    spec.version      = "1.0.1"
    spec.summary      = "eIDCheckSDK is the most accurate sdk that reads/scans NFC information."
    spec.description  = <<-DESC
                        eIDCheckSDK is an SDK widely used in reading NFC information from electronic chips, in the fastest and most accurate way.
                         DESC
    spec.homepage     = "https://plugins.gradle.org/u/TranHoaiHung"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author       = { "Tran Hoai Hung" => "eidcheckvn@gmail.com" }
    spec.platform     = :ios, "14.0"
    spec.source       = { :git => 'https://github.com/TranHoaiHung/eIDCheck-SDK.git', :tag => spec.version.to_s }
    spec.source_files = 'eIDCheckSDK.xcframework/**/eIDCheckSDK.framework/Headers/*.h'
    spec.public_header_files =  'eIDCheckSDK.xcframework/**/eIDCheckSDK.framework/Headers/*.h'

    spec.ios.deployment_target = '14.0' 
    spec.swift_version = "5.0"

    spec.dependency "QKMRZScanner", '~> 3.0.0'
    spec.dependency "OpenSSL-Universal", '1.1.1100'

    spec.xcconfig          = { 'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit' }

    spec.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  end
  