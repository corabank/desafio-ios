# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'cora' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for cora
  pod 'SwiftLint'
  pod 'Swinject', '2.7.1'

  target 'coraTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'SwiftyMocky'
  end

  target 'coraUITests' do
    # Pods for testing
  end

end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
          config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'NO'
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
  end
end
