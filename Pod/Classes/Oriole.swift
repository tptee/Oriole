import Foundation

public extension CollectionType where Index: Comparable {
	/**
        Safely accesses a collection element by index.
        Credit: https://gist.github.com/brentdax/72f3fcc3274c0e5f12d7

        :param: safe The index of the element to access.

        :returns: The indexed element or nil if the index is out of bounds.
	*/
	public subscript(safe index: Index) -> Generator.Element? {
		guard startIndex <= index && index < endIndex else {
			return nil
		}
		return self[index]
	}

	/**
        Returns elements from a collection with multiple provided indices.
        If the collection has no elements at any of the provided indices,
        the returned array will be empty.

        :param: indices The indices of the desired elements

        :returns: An array of extracted elements.
    */
	public func at(indices: [Index]) -> [Generator.Element] {
		return indices.map { index in return self[safe: index] }.flatMap { $0 }
	}

	/**
        Determines if a callback is true for every element in a collection.

        :param: callback The callback to check each element against.

        :returns: True or false.
	*/
	public func every(callback: (Generator.Element) -> Bool) -> Bool {
		for element in self {
			if !callback(element) {
				return false
			}
		}
		return true
	}

	/**
        Determines if a callback is true for at least one element in a collection.

        :param: callback The callback to check each element against.

        :returns: True or false.
	*/
	public func some(callback: (Generator.Element) -> Bool) -> Bool {
		for element in self {
			if callback(element) {
				return true
			}
		}
		return false
	}

	/**
        Determines if a callback is true for zero elements in a collection.

        :param: callback The callback to check each element against.

        :returns: True or false.
	*/
	public func none(callback: (Generator.Element) -> Bool) -> Bool {
		return !self.some(callback)
	}

	/**
        Finds the first element in a collection that is true for a given callback.
        
        :param: callback The callback to check each element against.

        :returns: An element or nil if no element satisfied the callback.
	*/
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
	/**
        Returns the first element of a collection.
        
        :returns: The first element or nil if the collection is empty.
	*/
	public var head: Generator.Element? {
		return first
	}

	/**
        Returns all elements of a collection except for the last.
        
        Returns nil if the collection is empty.
        
        Returns a single-element SubSequence if the collection only has one element.

        :returns: A SubSequence of multiple elements.
	*/
	public var initial: SubSequence? {
		guard count > 0 else {
			return nil
		}
		guard count > 1 else {
			return self[startIndex...startIndex]
		}

		return self[startIndex..<endIndex - 1]
	}

	/**
        Returns all elements of a collection except for the first.

        Returns nil if the collection is empty.

        Returns a single-element SubSequence if the collection only has one element.

        :returns: A SubSequence of multiple elements.
	*/
	public var tail: SubSequence? {
		guard count > 0 else {
			return nil
		}
		guard count > 1 else {
			return self[startIndex...startIndex]
		}

		return self[startIndex + 1..<endIndex]
	}

	/**
        Returns the last element of a collection.

        :returns: The last element or nil if the collection is empty.
	*/
	public var last: Generator.Element? {
		return self[safe: endIndex - 1]
	}

	/**
        Returns a randomly chosen element from a collection.

        :returns: An element or nil if the collection is empty.
	*/
	public func sample() -> Generator.Element? {
		guard self.count > 0 else {
			return nil
		}

		// Use arc4random_uniform() instead of Swift's random()
		return self[Int(arc4random_uniform(UInt32(count)))]
	}
}

public extension Array {
	/**
        Divide an array into equal-length chunks. The final chunk
        may contain a remainder. If the chunk length is greater than
        the length of the original array, it returns the original array
        unaltered.
        
        Inspired by http://stackoverflow.com/q/26395766

        :param: splitSize The length of the chunks.

        :returns: An array of chunked arrays.
	*/
	public func chunk(splitSize: Int) -> [[Element]] {
		guard self.count > splitSize else {
			return [self]
		}

		return [Array(self[0..<splitSize])] +
			Array(self[splitSize..<self.count]).chunk(splitSize)
	}
}

public extension Dictionary {
    /**
        Given a dictionary, return a new dictionary with its values transformed by a closure.
        
        :param: transform A closure that transforms a value into another value.
    
        :returns: A dictionary with identical keys and transformed values.
    */
    public func mapValues(transform: (Value) -> (Value)) -> [Key: Value] {
        return self.reduce([Key: Value]()) { acc, pairs in
            let (key, value) = pairs
            var result = acc
            result.updateValue(transform(value), forKey: key)
            return result
        }
    }

    /**
        Merges another dictionary with the original dictionary. Right takes precedence.
    
        :param: dict A dictionary to merge into this one.
    
        :returns: A merged dictionary.
    */
    public func merge(dict: Dictionary) -> Dictionary {
        var original = self
        for (key, value) in dict {
            original.updateValue(value, forKey: key)
        }
        return original
    }

    /*
        Returns a dictionary containing pairs whose keys are in a whitelist.
    
        :param: whitelist An array of keys used to whitelist pairs.
    
        :returns: A dictionary with the whitelisted pairs.
    **/
    public func pluck(whitelist: [Key]) -> Dictionary {
        let pairs = self.filter { pairs in
            let (key, _) = pairs
            return whitelist.contains(key)
        }
        var plucked = [Key: Value]()
        for (key, value) in pairs {
            plucked.updateValue(value, forKey: key)
        }
        return plucked
    }

    /*
    Returns a dictionary containing pairs whose keys aren't in a blacklist.

    :param: whitelist An array of keys used to blacklist pairs.

    :returns: A dictionary without the whitelisted pairs.
    **/
    public func omit(blacklist: [Key]) -> Dictionary {
        let pairs = self.filter { pairs in
            let (key, _) = pairs
            return !blacklist.contains(key)
        }
        var filtered = [Key: Value]()
        for (key, value) in pairs {
            filtered.updateValue(value, forKey: key)
        }
        return filtered
    }
}