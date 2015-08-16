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
					expect(set.every { $0.characters.count > 2 }) == true
					expect(set.every { $0 == "Things" }) == false
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
		}
    }
}
