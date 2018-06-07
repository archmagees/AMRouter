source 'https://github.com/cocoapods/specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!


target 'AMRouter' do
  
  target 'AMRouterTests' do
      inherit! :search_paths
#      pod 'AMRouter', :path => './'
      pod 'Quick', :git => 'https://github.com/Quick/Quick.git'
      pod 'Nimble', :git => 'https://github.com/Quick/Nimble.git'
      pod 'OCMock', :git => 'https://github.com/erikdoe/ocmock.git'
  end
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.1'
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
        end
    end
end

