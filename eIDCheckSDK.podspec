Pod::Spec.new do |spec|
    spec.name         = "eIDCheckSDK"
    spec.version      = "1.0.14"
    spec.summary      = "eIDCheckSDK is the most accurate sdk that reads/scans NFC information."
    spec.description  = <<-DESC
                        eIDCheckSDK is an SDK widely used in reading NFC information from electronic chips, in the fastest and most accurate way.
                         DESC
    spec.homepage     = "https://plugins.gradle.org/u/TranHoaiHung"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author       = { "Tran Hoai Hung" => "eidcheckvn@gmail.com" }
    spec.platform     = :ios, "13.0"
    spec.source       = { :git => 'https://github.com/TranHoaiHung/eIDCheck-SDK.git', :tag => spec.version.to_s }
    spec.source_files = 'eIDCheckSDK.xcframework/**/eIDCheckSDK.framework/Headers/*.h'
    spec.public_header_files =  'eIDCheckSDK.xcframework/**/eIDCheckSDK.framework/Headers/*.h'
    spec.ios.vendored_frameworks = 'eIDCheckSDK.xcframework'
    spec.ios.deployment_target = '13.0'
    spec.swift_version = "5.0"

    spec.dependency "OpenSSL-Universal", '1.1.1100'
  
    spec.xcconfig = {
      'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit',
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/OpenSSL-Universal'
    }
  
    spec.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    
    spec.user_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
  
  end