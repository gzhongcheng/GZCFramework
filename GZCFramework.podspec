
Pod::Spec.new do |s|

  s.name         = "GZCFramework"
  s.version      = “1.0.0”
  s.summary      = "项目常用到的控件、方法整理，方便调用”
  s.description  = <<-DESC
			项目常用到的控件、方法整理，方便调用
                   DESC

  s.homepage     = "https://github.com/gzhongcheng/GZCFramework"

  s.license      = "MIT"
  s.author       = { “郭忠橙” => "gzhongcheng@qq.com" }
  s.platform     = :ios, “8.0”

  s.source       = { :git => "https://github.com/gzhongcheng/GZCFramework.git", :tag => s.version.to_s }
  s.source_files  = “GZCFramework/*”
  
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

  
end
