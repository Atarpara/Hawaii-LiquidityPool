const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Pool Factory", function () {
  let luluToken;
  let volcanoToken;
  let poolsFactory;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  beforeEach(async function () {
    const PoolsFactory = await ethers.getContractFactory("PoolsFactory");
    const LuluToken = await ethers.getContractFactory("LuluToken");
    const VolcanoToken = await ethers.getContractFactory("VolcanoToken");

    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    luluToken = await LuluToken.deploy();
    volcanoToken = await VolcanoToken.deploy();
    poolsFactory = await PoolsFactory.deploy();
  });

  it("should created a new pool", async () => {
    await poolsFactory
      .connect(addr1)
      .createPool(
        luluToken.address,
        volcanoToken.address,
        `${luluToken.symbol}-${volcanoToken.symbol}`,
        `${luluToken.symbol}-${volcanoToken.symbol}`
      );

    expect(await poolsFactory.connect(addr1).allPoolsLength()).to.equal(1);

    const poolAddress = await poolsFactory
      .connect(addr1)
      .getPool(luluToken.address, volcanoToken.address);

    const liquidityPool = await ethers.getContractAt(
      "LiquidityPool",
      poolAddress
    );

    expect(await liquidityPool.tokenA()).to.be.equal(luluToken.address);

    expect(await liquidityPool.tokenB()).to.be.equal(volcanoToken.address);
  });
});
