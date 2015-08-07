import Foundation

public extension CollectionType where Index: Comparable {
	// Credit: https://gist.github.com/brentdax/72f3fcc3274c0e5f12d7
	public subscript(safe index: Index) -> Generator.Element? {
		guard startIndex <= index && index < endIndex else {
			return nil
		}
		return self[index]
	}

	public func at(indices: [Index]) -> [Generator.Element]? {
		return indices.map { index in return self[safe: index] }.flatMap { $0 }
	}

	public func every(callback: (Generator.Element) -> Bool) -> Bool {
		for element in self {
			if !callback(element) {
				return false
			}
		}
		return true
	}

	public func find(callback: (Generator.Element) -> Bool) -> Generator.Element? {
		for element in self {
			if callback(element) {
				return element
			}
		}
		return nil
	}

}

// Helper function for chunk
// Inspired by http://stackoverflow.com/q/26395766
private func chunkArray<T>(s: [T], _ splitSize: Int) -> [[T]] {
	if s.count <= splitSize {
		return [s]
	} else {
		return [Array(s[0..<splitSize])] + chunkArray(
			Array(s[splitSize..<s.count]), splitSize
		)
	}
}

public extension Array {
	public func chunk(length: Int) -> [[Element]] {
		return chunkArray(self, length)
	}
}

// Use Set for set operations.