Pod::Spec.new do |s|
  s.name         = "GZCFrameWork"
  s.version      = "2.0.0"
  s.summary      = "GZCFrameWork desc"

  s.homepage     = "https://github.com/gzhongcheng"
  s.license         = { type: 'MIT', file: 'LICENSE' }

  s.author       = { "gzhongcheng" => "gzhongcheng@qq.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/gzhongcheng/GZCFramework.git",:tag => s.version}
  s.source_files = "GZCFrameWork/**/*.{h,m}"
  s.resources    = "GZCFrameWork/GZCAssets.xcassets"
  s.requires_arc = true
  s.dependency 'TouchJSON'
  s.dependency 'MBProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'AFNetworking'
  s.dependency 'SDAutoLayout'
  s.dependency 'FLAnimatedImage'
  s.dependency 'pop'
end 
