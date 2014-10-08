#
# Be sure to run `pod lib lint AKUAssetManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AKUAssetManager"
  s.version          = "0.1.3"
  s.summary          = "Easy to check authorizationStatus of Camera/Photo."
  s.description      = <<-DESC
                       Easy to check authorizationStatus of Camera/Photo.

                       if not allow to access camera or photo, this library show warning alert.
                       DESC
  s.homepage         = "https://github.com/akuraru/AKUAssetManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "akuraru" => "akuraru@gmail.com" }
  s.source           = { :git => "https://github.com/akuraru/AKUAssetManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/akuraru'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'AKUAssetManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AssetsLibrary', 'AVFoundation'
  s.dependency 'Lambda-Alert'
end
