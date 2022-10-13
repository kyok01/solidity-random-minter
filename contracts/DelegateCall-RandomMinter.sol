// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import {calcFuncs, Data, Result} from "./library/CalcFuncs.sol";

contract DelegateCall is ERC20, Ownable, ERC20Permit {
    using calcFuncs for uint256;
    uint256 randomRange;
    uint256 private _nonce = 0;

    Data randomResult;
    using calcFuncs for Data;

    using Counters for Counters.Counter;
    Counters.Counter private _rIdCounter;

    constructor(uint256 _randomRange)
        ERC20("MyToken", "MTK")
        ERC20Permit("MyToken")
    {
        randomRange = _randomRange;
    }

    function randomMint(address _contract, uint256 _amount) public{
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("randomMint(uint256)", _amount)
        );

        // If the function call succeeded
        if (!success) {
            // If function did not succeed then revert with
            // error message if there is one.
            if (data.length > 0) {
                // bubble up the error
                revert(string(data));
            } else {
                revert("myFunction had an error");
            }
        }
    }

    function getRandomResult(uint256 rId) public view returns (Result memory) {
        return randomResult.results[rId];
    }
}
