// https://github.com/Quick/Quick

import Quick
import Nimble
import Oriole

class OrioleSpec: QuickSpec {
    override func spec() {
		describe("Oriole") {
			context("CollectionType") {
				it("safely accesses a collection element by index") {
					let array = [4, 8, 15, 16, 23, 42]
					expect(array[safe: 0]) == 4
					expect(array[safe: 6]).to(beNil())
				}

				it("safely retrieves multiple elements from a collection by index") {
					let array = [5, 4, 3, 2, 1]
					expect(array.at([0, 1, 4])) == [5, 4, 1]
					expect(array.at([1, 5, 90])) == [4]
					expect(array.at([90])) == []
				}

				it("determines if a callback is true for every collection element") {
					let set: Set = ["Things", "and", "other", "stuff"]
					expect(set.every { $0.characters.count > 2 }) == true
					expect(set.every { $0 == "Things" }) == false
				}

				it("determines if a callback is true for at least one collection element") {
					let array = [9, 7, 5, 3]
					expect(array.some { $0 > 3 }) == true
					expect(array.some { $0 > 10 }) == false
				}

				it("determines if a callback is false for every collection element") {
					let set: Set = [9.8, 29.4, 1000.3, 234567.89]
					expect(set.none { $0 < 0 }) == true
					expect(set.none { $0 < 10000 }) == false
				}

				it("finds the first element in a collection that returns true in a callback") {
					let array = [8, 6, 7, 5, 3, 0, 9]
					expect(array.find({$0 < 7})) == 6
				}

				it("retrieves the first element of a collection") {
					let array = [1, 2]
					expect(array.head) == 1
					let surprise: [Int] = []
					expect(surprise.head).to(beNil())
				}

				it("retrieves everything but the last element of a collection") {
					let array = [1, 3, 5, 7, 9, 11]
					expect(Array(array.initial!)) == [1, 3, 5, 7, 9]
					expect(Array([1].initial!)) == [1]
					expect([Int]().initial).to(beNil())
				}

				it("retrieves everything but the first element of a collection") {
					let array = ["some", "mammals", "have", "tails"]
					expect(Array(array.tail!) == ["mammals", "have", "tails"])
					expect(Array(["tails"].tail!) == ["tails"])
					expect([String]().tail).to(beNil())
				}

				it("retrieves the last element of a collection") {
					let array = [8, 6, 7, 5, 3, 0, 9]
					expect(array.last) == 9
					expect([Int]().last).to(beNil())
				}
			}

			context("Array") {
				it("safely divides a collection into multiple collections with a possible remainder") {
					let array = ["This", "is", "a", "test"]
					expect(array.chunk(2)) == [["This", "is"], ["a", "test"]]
					expect(array.chunk(3)) == [["This", "is", "a"], ["test"]]
				}
			}

            context("Dictionary") {
                it("returns a new dictionary with its values transformed by a closure") {
                    let dict = [
                        "Test": 1,
                        "ing": 2
                    ]
                    expect(dict.mapValues { $0 * 2 }) == [
                        "Test": 2,
                        "ing": 4
                    ]
                    let anotherDict = [
                        "Doot": "doot",
                        "Mr.": "Skeltal"
                    ]
                    expect(anotherDict.mapValues { $0 + " doot!"} ) == [
                        "Doot": "doot doot!",
                        "Mr.": "Skeltal doot!"
                    ]
                }

                it("merges two dictionaries") {
                    let original = ["This": "is a test"]
                    let new = [
                        "No need": "for alarm",
                        "This": "is not a drill"
                    ]
                    expect(original.merge(new)) == [
                        "This": "is not a drill",
                        "No need": "for alarm"
                    ]
                }

                it("returns a new dictionary where each pair's key is in a whitelist") {
                    let dict = [
                        "I want": "this",
                        "I also want": "this",
                        "I don't want": "this"
                    ]
                    expect(dict.pluck(["I want", "I also want"])) == [
                        "I want": "this",
                        "I also want": "this"
                    ]
                }

                it("returns a new dictionary where each pair's key isn't in a blacklist") {
                    let dict = [
                        "I want": "this",
                        "I also want": "this",
                        "I don't want": "this"
                    ]
                    expect(dict.omit(["I don't want"])) == [
                        "I want": "this",
                        "I also want": "this"
                    ]
                }
            }
		}
    }
}
