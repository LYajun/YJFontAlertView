#
# Be sure to run `pod lib lint YJFontAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJFontAlertView'
  s.version          = '1.0.3'
  s.summary          = '字体设置'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LYajun/YJFontAlertView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LYajun' => 'liuyajun1999@icloud.com' }
  s.source           = { :git => 'https://github.com/LYajun/YJFontAlertView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YJFontAlertView/Classes/**/*.{h,m}'
  
  s.resources = 'YJFontAlertView/Classes/YJFontAlertView.bundle'
  
  s.dependency 'YJExtensions'
  s.dependency 'Masonry'
end
