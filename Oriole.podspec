Pod::Spec.new do |s|
  s.name             = "Oriole"
  s.version          = "0.2.0"
  s.summary          = "Oriole is a set of protocol extensions that add useful helper methods to Swift collections."
  s.description      = <<-DESC
                      Oriole is a set of protocol extensions that add useful helper methods to Swift collections. Oriole resembles libraries like Dollar and ExSwift (which in turn take inspiration from Lodash), but with some ideological differences:

                      - Oriole uses Swift 2.0's new protocol extensions to provide more natural APIs.
                      - Oriole strives to be as generic as possible. Most methods extend CollectionType. Oriole extends concrete collections like Array, Set, and Dictionary only if necessary.
                      - Oriole fills in gaps in the Swift standard library. If a method is trivially reproducible by methods in the standard library, it is not included.
                      - Oriole prefers to implement functional solutions to problems. However, if an imperative solution is elegant and significantly more performant, it will replace the functional solution.
                       DESC
  s.homepage         = "https://github.com/tptee/Oriole"
  s.license          = 'MIT'
  s.author           = { "Tyler Thompson" => "tyler@tylerpaulthompson.com" }
  s.source           = { :git => "https://github.com/tptee/Oriole.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Oriole' => ['Pod/Assets/*.png']
  }

end
