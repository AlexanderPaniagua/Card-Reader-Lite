require 'json'

package = JSON.parse(File.read(File.join(__dir__, '..', 'package.json')))

Pod::Spec.new do |s|
  s.name           = 'CardReaderLite'
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = package['homepage']
  s.platforms      = { ios: '15.1', tvos: '15.1' }
  s.swift_version  = '5.9'
  s.source         = { git: 'https://github.com/AlexanderPaniagua/card-reader-lite' }
  s.static_framework = true

  s.dependency 'ExpoModulesCore'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'SWIFT_OPTIMIZATION_LEVEL' => '-Onone'
  }

  # ✅ Fixed source paths (relative to ios/)
  s.source_files = [
    'ios/CardReader/**/*.{swift,h,m,mm}'
  ]
end