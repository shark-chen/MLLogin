#
# Be sure to run `pod lib lint MLLogin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MLLogin'
  s.version          = '1.0.3'
  s.summary          = 'login SDK to game.'
  s.static_framework = true
  s.swift_version    = '5.0.0'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/shark-chen/MLLogin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'git' => '1533503916@qq.com' }
  s.source           = { :git => 'https://github.com/shark-chen/MLLogin.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.prefix_header_contents = '@import FBSDKLoginKit;', '@import AuthenticationServices;', '@import GoogleSignIn;'
  
  s.pod_target_xcconfig = {
#      'CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF' => 'NO',
#      'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO',
#      'GCC_PREPROCESSOR_DEFINITIONS' => 'GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
      'OTHER_LDFLAGS' => ['$(inherited)','-ObjC'],
  }
  
  s.subspec 'MLLogin' do |sp|
    sp.source_files = 'MLLogin/Classes/MLLogin/**/*'
    sp.dependency 'MLLogin/Tool'
    sp.dependency 'MLLogin/MLNetwork'
  end
  
  s.subspec 'MLNetwork' do |sp|
    sp.public_header_files = 'MLLogin/Classes/MLNetwork/*.h'
    sp.source_files = 'MLLogin/Classes/MLNetwork/**/*'
  end
  
  s.subspec 'Tool' do |sp|
    sp.public_header_files = 'MLLogin/Classes/Tool/**/*.h'
    sp.source_files = 'MLLogin/Classes/Tool/**/*'
  end
  
  s.subspec 'Resouces' do |sp|
    sp.resources    = 'MLLogin/Resouces/*.{bundle}'
  end

  s.frameworks =  "Foundation","UIKit"
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.dependency 'FBSDKLoginKit'
   s.dependency 'GoogleSignIn'
  # s.dependency 'AFNetworking', '~> 2.3'
end
