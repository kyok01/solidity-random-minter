// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import {calcFuncs, Data, Result} from "./library/CalcFuncs.sol";
import {IRandomMinter} from "./interfaces/IRandomMinter.sol";

contract RandomMinter is
    ERC20,
    ERC20Burnable,
    Ownable,
    ERC20Permit,
    IRandomMinter
{
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

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    function randomMint(uint256 amount) public {
        bool minted = false;
        if (randomRange._random() == 0) {
            _mint(msg.sender, amount);
            emit Mint(msg.sender, amount);
            minted = true;
        }
        _setRandomResult(msg.sender, amount, minted);
    }

    // functions about randomResult
    function getRandomResult(uint256 rId) public view returns (Result memory) {
        return randomResult.results[rId];
    }

    function _setRandomResult(
        address sender,
        uint256 amount,
        bool minted
    ) internal {
        uint256 rId = _rIdCounter.current();
        _rIdCounter.increment();
        randomResult._recordResult(rId, sender, amount, minted);
    }

    // functions to learn usage of library
    function addFunc(uint256 a) external pure returns (uint256) {
        return calcFuncs.add(a, 3);
    }

    function getRandomNum() public view returns (uint256) {
        return randomRange._random();
    }
}
