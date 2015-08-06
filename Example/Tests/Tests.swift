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
				}

				it("determines if a callback is true for every collection element") {
					let set = Set(arrayLiteral: "Things", "and", "other", "stuff")
					expect(set.every { $0.characters.count > 3 }) == true
					expect(set.every { $0 == "Things" }) == false
				}
			}

			context("Array") {
				it("safely divides a collection into multiple collections with a possible remainder") {
					let array = ["This", "is", "a", "test"]
					expect(array.chunk(2)) == [["This", "is"], ["a", "test"]]
					expect(array.chunk(3)) == [["This", "is", "a"], ["test"]]
				}
			}
		}
    }
}
