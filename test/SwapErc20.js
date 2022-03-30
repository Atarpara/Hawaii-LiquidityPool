const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TomNook ATM contract", function () {

    let Token;
    let hardhatToken;
    let owner;
    let addr1;
    let addr2;
    let addrs;


    beforeEach(async function () {
        SwapErc20 = await ethers.getContractFactory("SwapErc20");
        const LuluToken = await ethers.getContractFactory("LuluToken");
        const VolcanoToken = await ethers.getContractFactory("VolcanoToken");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        const luluToken = await LuluToken.deploy();
        const volcanoToken = await VolcanoToken.deploy();
        hardhatToken = await TomNookATM.deploy(luluToken.address, volcanoToken.address);
    });

});
