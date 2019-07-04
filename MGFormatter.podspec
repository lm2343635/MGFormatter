#
# Be sure to run `pod lib lint MGFormatter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGFormatter'
  s.version          = '0.4.1'
  s.summary          = 'A code formatting library for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MGFormatter can format the JSON or HRML code in a view with customized keyword color and font.
                       DESC

  s.homepage         = 'https://github.com/lm2343635/MGFormatter'
  s.screenshots      = 'https://raw.githubusercontent.com/lm2343635/MGFormatter/master/screenshot/json-dark.png', 'https://raw.githubusercontent.com/lm2343635/MGFormatter/master/screenshot/html-dark.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/lm2343635/MGFormatter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/lm2343635/MGFormatter'

  s.ios.deployment_target = '9.0'
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  
  s.dependency 'SwiftyJSON', '~> 4.3'
  s.dependency 'Fuzi', '~> 3'
  s.dependency 'AttributedTextView', '~> 1.3'
  
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
      core.source_files = 'MGFormatter/Classes/Core/**/*'
      core.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  end
  
  s.subspec 'Rx' do |rx|
      rx.dependency 'MGFormatter/Core', '~> 0'
      rx.dependency 'RxCocoa', '~> 4.5'
      rx.source_files = 'MGFormatter/Classes/Rx/**/*'
  end
  
end
