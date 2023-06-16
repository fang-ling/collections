import XCTest
@testable import xhl

final class UnionFindSetTests: XCTestCase {
    func test_example() {
        var ufs = UnionFindSet<Int>()

        let tier1 = [19358, 19348, 19342, 19333]
        for i in tier1 {
            ufs.make_set(i)
        }
        for i in tier1 {
            for j in tier1 {
                if i != j {
                    XCTAssertTrue(ufs.find_set(i) != ufs.find_set(j))
                } else {
                    XCTAssertFalse(ufs.find_set(i) != ufs.find_set(j))
                }
            }
        }
        for i in tier1 {
            for j in tier1 {
                ufs.union(i, j)
            }
        }
        for i in tier1 {
            for j in tier1 {
                XCTAssertTrue(ufs.find_set(i) == ufs.find_set(j))
            }
        }

        let tier2 = [12333, 12361, 12321, 12308, 12306]
        for i in tier2 {
            ufs.make_set(i)
        }
        for i in tier2 {
            for j in tier2 {
                ufs.union(i, j)
            }
        }
        for i in tier1 {
            for j in tier2 {
                XCTAssertTrue(ufs.find_set(i) != ufs.find_set(j))
            }
        }
    }
}
