// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
 
 
  const controllerContract = await ethers.getContractFactory("Controller");
  const Controller= await controllerContract.deploy({gas:"10000000", gasPrice:"200000000000"});
  await Controller.waitForDeployment();
  console.log("controllerContract deployed at:", Controller.target);
  
  const setttingsContract = await ethers.getContractFactory("Settings");
  const Settings= await setttingsContract.deploy(Controller.target , "0xc3A1D9C337c4E1EeFC95AD4d1418a5e04F365C6a" ,{gas:"10000000", gasPrice:"200000000000"});
  await Settings.waitForDeployment();
  console.log("Settings contract  deployed at:", Settings.target);
  
  const feeContract = await ethers.getContractFactory("FeeController");
  const feeController= await feeContract.deploy(Controller.target , Settings.target,{gas:"10000000", gasPrice:"200000000000"});
  await feeController.waitForDeployment();
  console.log("feeController contract  deployed at:", feeController.target);


  const registryContract = await ethers.getContractFactory("Registry");
  const registry = await registryContract.deploy({gas:"10000000", gasPrice:"200000000000"});
  await registry.waitForDeployment();

  console.log("registry contract  deployed at:", registry.target);

  const bridgeContract = await ethers.getContractFactory("Bridge");
  const bridge = await bridgeContract.deploy(Controller.target , Settings.target, registry.target , feeController.target,{gas:"10000000", gasPrice:"200000000000"});
  await bridge.waitForDeployment();

  console.log("bridgeContract contract  deployed at:", bridge.target );

  await registry.transferOwnership(bridge.target ,{gas:"10000000", gasPrice:"200000000000"});
  console.log("transfering ownership" );

    const nftContract = await ethers.getContractFactory("SimpleNFT");
  const nft = await nftContract.deploy("testNFT", "TNFT", "1000" ,{gas:"10000000", gasPrice:"200000000000"});
  await nft.waitForDeployment();

  console.log("nft contract  deployed at:", nft.target);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
