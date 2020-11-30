# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CPSC575Project' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CPSC575Project
  pod 'MessageKit'
  pod 'Firebase/Core'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  
  post_install do |installer|
  installer.pods_project.targets.each do |target|
      if target.name == 'MessageKit'
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.2'
          end
      end
  end
  
end
end
