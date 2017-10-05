Pod::Spec.new do |s|
  s.name = 'GZCFramework'
  s.version = '1.0.1'
  s.license = 'MIT'
  s.summary = '项目常用的方法、控件整理'
  s.description = '项目常用的方法、控件整理 Object-C'
  s.homepage = 'https://github.com/gzhongcheng/GZCFramework'
  s.author = { 'gzc' => 'guozhongcheng@qq.com' }
  s.source = { :git => 'https://github.com/gzhongcheng/GZCFramework.git', :tag => "#{s.version}" }
  s.requires_arc = true
  s.prefix_header_contents = '#import <UIKit/UIKit.h>', '#import <Foundation/Foundation.h>'
  s.ios.deployment_target = '7.0'
  s.frameworks = 'UIKit','Foundation'
  s.source_files = 'GZCFrameWork/**/**/*.{h,m}'
  #spec.source_files = 'Classes/**/*.{h,m}', 'More_Classes/**/*.{h,m}'
  s.ios.vendored_library = 'GZCFrameWork/Lib/libmp3lame.a'
  #s.ios.vendored_frameworks  = 'GZCFrameWork/Lib/AMapLocationKit.framework'
  s.resources = 'GZCFrameWork/Resouse/*'
  #s.dependency "SDWebImage" , "~> 3.7.6"
  #s.dependency "AMapLocation" , "~> 1.2.2"
  #s.dependency "AFNetworking" , "~> 3.1.0"
end
