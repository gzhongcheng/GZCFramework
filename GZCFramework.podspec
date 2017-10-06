Pod::Spec.new do |s|
  s.name         = "GZCFramework"
  s.version      = "2.0.4"
  s.summary      = "GZCFrameWork desc"

  s.homepage     = "https://github.com/gzhongcheng"
  s.license         = { type: 'MIT', file: 'LICENSE' }

  s.author       = { "gzhongcheng" => "gzhongcheng@qq.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/gzhongcheng/GZCFramework.git",:tag => s.version}
  s.source_files = "GZCFrameWork/*.{h,m}"
    s.subspec 'Define' do |ss|
        ss.source_files = 'GZCFrameWork/Define/*.{h,m}'
    end
    s.subspec 'Api' do |ss|
        ss.source_files = 'GZCFrameWork/Api/*.{h,m}'
    end
    s.subspec 'Category' do |ss|
        ss.source_files = 'GZCFrameWork/Category/*.{h,m}'
    end
    s.subspec 'Http' do |ss|
        ss.source_files = 'GZCFrameWork/Http/*.{h,m}'
    end
    s.subspec 'Resouse' do |ss|
        ss.source_files = 'GZCFrameWork/Resouse/*.{h,m}'
    end
    s.subspec 'UI' do |ss|
        ss.source_files = 'GZCFrameWork/UI/*.{h,m}'
    end
    s.subspec 'BaseClass' do |ss|
        ss.source_files = 'GZCFrameWork/BaseClass/*.{h,m}'
    end
  s.resources    = "GZCFrameWork/Resouse/*.{png}"
  s.requires_arc = true
  s.dependency 'TouchJSON'
  s.dependency 'MBProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'AFNetworking'
  s.dependency 'SDAutoLayout'
  s.dependency 'FLAnimatedImage'
  s.dependency 'pop'
end 
