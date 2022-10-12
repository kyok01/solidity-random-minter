// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./interfaces/IRandomMinter.sol";

contract CallWithInterface {
    function callExternalFunction(address _calleeAddr, uint256 amount) public {
        IRandomMinter callee = IRandomMinter(_calleeAddr);
        callee.randomMint(amount);
    }
}
