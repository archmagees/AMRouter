Pod::Spec.new do |s|
  s.name            = 'AMRouter'
  s.module_name     = 'AMRouter'
  s.version         = '0.2.0'
  s.summary         = 'AMRouter'
  s.description     = <<-DESC
                    This is AMRouter.
                    DESC
  s.homepage        = 'https://github.com/archmagees/AMRouter'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Arthur' => 'archmagees@gmail.com' }
  s.platform        = :ios, '9.0'
  s.swift_version   = '4.1'
  s.source          = { :git => 'https://github.com/archmagees/AMRouter.git', :tag => s.version.to_s }
  s.source_files    = 'AMRouter/AMRouter/**/*.{h,m}'
#   s.vendored_framework = "Carthage/Build/iOS/AMRouter.framework"
  s.requires_arc    = true
end
