Pod::Spec.new do |s|
  s.name = 'Observer'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'Observer in Swift'
  s.homepage = 'https://github.com/khlopko/Observer'
  s.authors = { 'Kirill Khlopko' => 'khlopko@gmail.com' }
  s.source = { :git => 'https://github.com/khlopko/Observer.git', :tag => s.version }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/*.swift'
end
