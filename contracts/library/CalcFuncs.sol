// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

struct Result {
    address sender;
    uint256 amount;
    bool minted;
}

// Only constant variables are allowed at file level, so you cannot declare mapping at file level
struct Data {
    mapping(uint256 => Result) results;
}

library calcFuncs {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    function _random(uint256 _randomRange) internal view returns (uint) {
        // sha3 and now have been deprecated
        return
            uint(
                keccak256(abi.encodePacked(block.difficulty, block.timestamp))
            ) % _randomRange;
    }

    function _recordResult(
        Data storage self,
        uint256 id,
        address sender,
        uint256 amount,
        bool minted
    ) internal {
        self.results[id] = Result(sender, amount, minted);
    }
}
