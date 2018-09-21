#
# Be sure to run `pod lib lint MGFormatter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGFormatter'
  s.version          = '0.2'
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
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MGFormatter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MGFormatter' => ['MGFormatter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'SwiftyJSON', '~> 4'
  s.dependency 'Fuzi', '~> 2'
  s.dependency 'AttributedTextView', '~> 1.2'
  s.dependency 'SnapKit', '~> 4'
  
end
