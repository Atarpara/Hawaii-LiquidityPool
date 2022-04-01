async function main() {
  const LuluToken = await hre.ethers.getContractFactory("LuluToken");
  const VolcanoToken = await hre.ethers.getContractFactory("VolcanoToken");
  const SwapErc20 = await hre.ethers.getContractFactory("SwapErc20");
  const FactoryContract = await hre.ethers.getContractFactory("PoolFactory");

  console.log("Deploying contracts...");

  const luluToken = await LuluToken.deploy();
  await LuluToken.deployed();
  const volcanoToken = await VolcanoToken.deploy();
  await VolcanoToken.deployed();
  const swapErc20 = await TomNookATM.deploy(
    luluToken.address,
    volcanoToken.address
  );
  await swapErc20.deployed();
  const factoryContract = await FactoryContract.deploy();
  await FactoryContract.deployed();

  console.log("Bells token deployed at:", luluToken.address);
  console.log("Miles token deployed at:", volcanoToken.address);
  console.log("TomNookATM deployed to:", swapErc20.address);
  console.log("Factory contract deployed at:", factoryContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
