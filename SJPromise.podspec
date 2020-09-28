Pod::Spec.new do |s|

  s.name         = "SJPromise"
  s.version      = "1.0.0"
  s.summary      = "SJPromise is a very simple promise library for Objective-C."
  s.homepage     = "https://github.com/slientjack/SJPromise"
  s.license      = "MIT"
  s.author       = { "jack" => "zhpsyz113@126.com" }
  s.source        = { :git => "https://github.com/slientjack/SJPromise.git", :tag => s.version.to_s }
  s.source_files  = "SJPromise/*.{h,m}"
  s.requires_arc  = true

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
end
