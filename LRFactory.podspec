Pod::Spec.new do |s|
    
    s.name         = "LRFactory"
    s.version      = "2.2.1"
    s.summary      = "LRFactory"
    s.description  = <<-DESC
					 封装视图控件，用于方便调用
                   DESC

    s.homepage     = "https://github.com/Wmileo/SimpleView"
    s.license      = "MIT"
    s.author       = { "leo" => "work.mileo@gmail.com" }

    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://github.com/Wmileo/SimpleView.git", :tag => s.version.to_s }

    s.requires_arc = true

    s.subspec "LRFactory" do |ss|
        ss.source_files = 'SimpleView/LRFactory/*'
    end

    s.subspec "LRAnimationFactory" do |ss|
        ss.source_files = 'SimpleView/LRAnimationFactory/*'
    end

    s.subspec "LRUIFactory" do |ss|
        ss.source_files = 'SimpleView/LRUIFactory/*'
        ss.dependency 'LRFactory/LRFactory'
    end
  
    s.subspec "LRVCExtend" do |ss|
        ss.source_files = 'SimpleView/LRVCExtend/*'
        ss.dependency 'LRFactory/LRUIFactory'
    end

    s.subspec "LRVCStyle" do |ss|
        ss.source_files = 'SimpleView/LRVCStyle/*'
        ss.dependency 'LRFactory/LRUIFactory'
        ss.dependency 'LRFactory/LRVCExtend'
    end

end
