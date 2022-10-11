// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IRandomMinter {
    function mint(address to, uint256 amount) external;
    function randomMint(uint256 amount) external;
    function addFunc(uint256 a) pure external returns(uint256);
    function getRandomNum() view external returns(uint256);
}