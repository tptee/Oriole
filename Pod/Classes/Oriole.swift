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

public extension CollectionType where Index.Distance == Int, Index == Int {
	public var head: Generator.Element? {
		return first
	}

	public var initial: SubSequence? {
		guard count > 0 else {
			return nil
		}
		guard count > 1 else {
			return self[startIndex...startIndex]
		}

		return self[startIndex..<endIndex - 1]
	}

	public var tail: SubSequence? {
		guard count > 0 else {
			return nil
		}
		guard count > 1 else {
			return self[startIndex...startIndex]
		}

		return self[startIndex + 1..<endIndex]
	}

	public var last: Generator.Element? {
		return self[safe: endIndex - 1]
	}

	public func sample() -> Generator.Element {
		// Use arc4random_uniform() instead of Swift's random()
		return self[Int(arc4random_uniform(UInt32(count)))]
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