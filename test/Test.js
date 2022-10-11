const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { ethers } = require("hardhat");

describe("random-minter", function () {
  async function deployTokenFixture() {
    // ArchiveCoin Contract
    const ARCV = await ethers.getContractFactory("RandomMinter");
    const [owner, addr1, addr2] = await ethers.getSigners();

    const Contract = await ARCV.deploy(2);

    await Contract.deployed();

    // Fixtures can return anything you consider useful for your tests
    return { Contract, owner, addr1, addr2 };
  }
  it("Mint", async function () {
    const { Contract, owner, addr1, addr2 } = await loadFixture(
      deployTokenFixture
    );

    await Contract.mint(owner.address, 5);
    ownerBalance = await Contract.balanceOf(owner.address);
    console.dir("owner=" + ownerBalance);

    const result = await Contract.addFunc(5);
    console.dir("result: " + result);

    const randomNum = await Contract.getRandomNum();
    console.dir("randomNum: " + randomNum);
  });
});