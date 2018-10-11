Pod::Spec.new do |s|

  s.name         = "LGLocker"
  s.version      = "1.0.0"
  s.summary      = "点控控制"

  s.homepage     = "https://github.com/LYajun/LGLocker"
 

  s.license      = "MIT"

  s.author             = { "刘亚军" => "liuyajun1999@icloud.com" }


  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'


  s.source  = { 
                :git => "https://github.com/LYajun/LGLocker.git",
                :tag => s.version
  }

  s.source_files  = "LGLocker/*.{h,m}"
 
 
  s.resources = "LGLocker/LGLocker.bundle"

  s.requires_arc = true

  s.dependency 'Masonry'

end