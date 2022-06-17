Pod::Spec.new do |s|
	s.name         = 'SimpleUserDefaults'
	s.version      = '0.1.0'
	s.swift_versions = ['5.5']
	s.summary      = 'Simple User Defaults via Property Wrappers'
	s.homepage     = 'https://github.com/marksands/SimpleUserDefaults'
	s.license      = { :type => 'MIT', :file => 'LICENSE' }
	s.author       = { 'Snir Orlanczyk' }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'

  s.source = { :git => 'https://github.com/SOSwifty/SimpleUserDefaults.git', :tag => s.version.to_s }
	s.source_files  = 'Sources/**/*.swift'
end
