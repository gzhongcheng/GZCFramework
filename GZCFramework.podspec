Pod::Spec.new do |s|
  s.name         = "GZCFramework"
  s.version      = "2.0.4"
  s.summary      = "GZCFramework desc"

  s.homepage     = "https://github.com/gzhongcheng"
  s.license         = { type: 'MIT', file: 'LICENSE' }

  s.author       = { "gzhongcheng" => "gzhongcheng@qq.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/gzhongcheng/GZCFramework.git",:tag => s.version}
  s.source_files = "GZCFramework/*.{h,m}"
    s.subspec 'Define' do |ss|
        ss.dependency 'GZCFramework/Category'
        ss.source_files = 'GZCFramework/Define/*.{h,m}'
        ss.public_header_files = 'GZCFramework/Define/*.h'
    end
    s.subspec 'Api' do |ss|
        ss.source_files = 'GZCFramework/Api/*.{h,m}'
        ss.public_header_files = 'GZCFramework/Api/*.h'
    end
    s.subspec 'Category' do |ss|
        ss.dependency 'GZCFramework/Define'
        ss.source_files = 'GZCFramework/Category/*.{h,m}'
        ss.public_header_files = 'GZCFramework/Category/*.h'
    end
    s.subspec 'Http' do |ss|
        ss.dependency 'GZCFramework/Category'
        ss.source_files = 'GZCFramework/Http/*.{h,m}'
        ss.public_header_files = 'GZCFramework/Http/*.h'
    end
    s.subspec 'Resouse' do |ss|
        ss.source_files = 'GZCFramework/Resouse/*.{h,m}'
        ss.public_header_files = 'GZCFramework/Resouse/*.h'
    end
    s.subspec 'UI' do |ss|
        ss.source_files = 'GZCFramework/UI/*.{h,m}'
        ss.public_header_files = 'GZCFramework/UI/*.h'
    end
    s.subspec 'BaseClass' do |ss|
        ss.dependency 'GZCFramework/Api'
        ss.dependency 'GZCFramework/Define'
        ss.source_files = 'GZCFramework/BaseClass/*.{h,m}'
        ss.public_header_files = 'GZCFramework/BaseClass/*.h'
    end
  s.resources    = "GZCFramework/Resouse/*.{png}"
  s.requires_arc = true
  s.dependency 'TouchJSON'
  s.dependency 'MBProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'AFNetworking'
  s.dependency 'SDAutoLayout'
  s.dependency 'FLAnimatedImage'
  s.dependency 'pop'
end 
