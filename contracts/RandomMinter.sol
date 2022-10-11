// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

import {calcFuncs} from "./library/CalcFuncs.sol";
import {IRandomMinter} from "./interfaces/IRandomMinter.sol";

contract RandomMinter is ERC20, ERC20Burnable, Ownable, ERC20Permit, IRandomMinter {
    using calcFuncs for uint256;
    uint256 randomRange;
    uint256 private _nonce = 0;

    constructor(uint256 _randomRange) ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        randomRange = _randomRange;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function randomMint(uint256 amount) public {
        if(randomRange._random() == 0) {
            _mint(msg.sender, amount);
        }
    }

    function addFunc(uint256 a) pure external returns(uint256) {
        return calcFuncs.add(a, 3);
    }

    function getRandomNum() view public returns(uint256) {
        return randomRange._random();
    }
}
