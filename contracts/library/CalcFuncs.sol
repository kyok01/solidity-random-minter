// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

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
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp
                    )
                )
            ) % _randomRange;
    }
}