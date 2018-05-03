Pod::Spec.new do |s|

  s.name         = "SimpleView"
  s.version      = "1.0.5"
  s.summary      = "SimpleView"
  s.description  = <<-DESC
					 封装视图控件，用于方便调用
                   DESC

  s.homepage     = "https://github.com/Wmileo/SimpleView"
  s.license      = "MIT"
  s.author       = { "leo" => "work.mileo@gmail.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Wmileo/SimpleView.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.subspec "Simple" do |simple|
    simple.source_files = 'SimpleView/Simple/*'
  end

  s.subspec "SimpleAnimation" do |simpleAnimation|
    simpleAnimation.source_files = 'SimpleView/SimpleAnimation/*'
  end

  s.subspec "SimpleView" do |simpleView|
    simpleView.source_files = 'SimpleView/SimpleView/*'
    simpleView.dependency 'SimpleView/Simple'
  end

  s.subspec "NavStyle" do |navStyle|
    navStyle.source_files = 'SimpleView/NavStyle/*'
    navStyle.dependency 'SimpleView/SimpleView'
  end

end
