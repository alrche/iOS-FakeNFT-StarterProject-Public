# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FakeNFT' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FakeNFT
  pod 'SwiftGen', '~> 6.0'
  pod 'SnapKit', '~> 5.0.1'
  pod 'SkeletonView'

  target 'FakeNFTTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FakeNFTUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
