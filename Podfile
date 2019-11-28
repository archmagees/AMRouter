platform :ios, '9.0'

#plugin 'cocoapods-binary'

inhibit_all_warnings!
use_frameworks!


target 'AMRouter' do
    pod 'CocoaLumberjack', '~>3.4.2'

  target 'AMRouterTests' do
      inherit! :search_paths
      pod 'AMRouter', :path => './'
      
      pod 'OCMock', :git => 'https://github.com/erikdoe/ocmock.git'
      
      pod 'Quick'
      pod 'Nimble'
  end
end

