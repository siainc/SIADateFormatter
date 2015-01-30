#
# Be sure to run `pod lib lint SIADateFormatter.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SIADateFormatter"
  s.version          = "0.1.0"
  s.summary          = "SIADateFormatter is automatically cached NSDateFormatter."
  s.description      = <<-DESC
                       SIADateFormatter is automatically cached NSDateFormatter.
                       Add utility method to NSString/NSDate.
                       DESC
  s.homepage         = "https://github.com/siagency/SIADateFormatter"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "SI Agency" => "support@si-agency.co.jp" }
  s.source           = { :git => "https://github.com/siagency/SIADateFormatter.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'SIADateFormatter' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
