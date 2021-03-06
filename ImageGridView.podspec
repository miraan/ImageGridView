#
# Be sure to run `pod lib lint ImageGridView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ImageGridView'
  s.version          = '0.1.0'
  s.summary          = 'A drag and drop, reorderable, image grid suitable for a profile picture selector.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pod gives you an image grid view which displays images. Images can be dragged and dropped to be reordered. There are buttons to delete images and add new images. The grid automatically resizes when more images are added. You can hook in delegate methods to control the behaviour when the user taps delete or add. This was originally designed for a profile picture selector on an edit profile screen.
                       DESC

  s.homepage         = 'https://github.com/miraan/ImageGridView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'miraan' => 'miraan@triprapp.com' }
  s.source           = { :git => 'https://github.com/miraan/ImageGridView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ImageGridView/Classes/**/*'
  
  s.resource_bundles = {
    'ImageGridView' => ['ImageGridView/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
