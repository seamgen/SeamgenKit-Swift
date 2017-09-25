#
# Be sure to run `pod lib lint SeamgenKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SeamgenKit'
  s.version          = '1.1.0'
  s.summary          = 'A collection of Swift utilities created by Seamgen'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A collection of Swift utilities created by Seamgen.
                       DESC

  s.homepage         = 'https://github.com/seamgen/SeamgenKit-Swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sam Gerardi' => 'sgerardi@seamgen.com' }
  s.source           = { :git => 'https://github.com/seamgen/SeamgenKit-Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.seamgen.com'

  s.ios.deployment_target = '9.3'

  s.source_files = 'SeamgenKit/Classes/**/*'
  s.frameworks = 'Foundation', 'UIKit', 'MapKit'
end
