const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { ethers } = require("hardhat");

describe("random-minter", function () {
  async function deployTokenFixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    // RandomMinter Contract
    const RM = await ethers.getContractFactory("RandomMinter");
    const Contract = await RM.deploy(2);
    await Contract.deployed();

    // RandomMinter Contract
    const CWI = await ethers.getContractFactory("CallWithInterface");
    const Contract2 = await CWI.deploy();
    await Contract2.deployed();

    // Fixtures can return anything you consider useful for your tests
    return { Contract, Contract2, owner, addr1, addr2 };
  }
  it("Mint", async function () {
    const { Contract, owner, addr1, addr2 } = await loadFixture(
      deployTokenFixture
    );

    await Contract.mint(owner.address, 5);
    ownerBalance = await Contract.balanceOf(owner.address);
    console.dir("owner=" + ownerBalance);

    const calcResult = await Contract.addFunc(5);
    console.dir("result: " + calcResult);

    const randomNum = await Contract.getRandomNum();
    console.dir("randomNum: " + randomNum);

    await Contract.connect(addr1).randomMint(5);
    let addr1Balance = await Contract.balanceOf(addr1.address);
    console.dir("owner=" + addr1Balance);

    const randomResult = await Contract.getRandomResult(0);
    console.dir("randomResult: " + randomResult);
  });

  it("external function calls", async function () {
    const { Contract, Contract2} = await loadFixture(
      deployTokenFixture
    );

    await Contract2.callExternalFunction(Contract.address, 3);

    const randomResult = await Contract.getRandomResult(0);

    // msg.sender is not owner.
    expect(randomResult.sender).to.equal(Contract2.address);
  });
});
