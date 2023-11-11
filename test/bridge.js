const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
  const { ethers } = require("hardhat");
const { deployContract } = require("@nomicfoundation/hardhat-ethers/types");
const utils = require('ethers').utils;

async function deployBridge() {
    //deployer factory
      const [deployer, account2  , account3 ] = await ethers.getSigners();
      
      const controllerContract  = await ethers.getContractFactory("Controller");
      const controller =  await controllerContract.deploy();

      const settingsContract  = await ethers.getContractFactory("Settings");
      const settings =  await settingsContract.deploy(controller , deployer);

      const feeControllerContract  = await ethers.getContractFactory("FeeController");
      const feeController =  await feeControllerContract.deploy(controller , settings);
    
      const registryContract  = await ethers.getContractFactory("Registry");
      const registry =  await registryContract.deploy();
    
      const bridgeContract  = await ethers.getContractFactory("Bridge");
      const bridge =  await bridgeContract.deploy(controller , settings, registry , feeController);

      await registry.transferOwnership(bridge);

      console.log(await registry.owner());


   return {controller , registry , feeController,  settings , bridge , deployer , account2 , account3}
   
  }


  describe("Deployment", function () {

    it("Should register Bridge", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        console.log(bridge.target);
        console.log(await registry.owner());
        
        expect(await registry.owner() == bridge.target ).to.be.true;
       });
       it("Should mint nft", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.mint(deployer , 1);

        expect(await NFT.ownerOf(1) == deployer.address ).to.be.true;
       });
       it("Should burn nft", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.mint(deployer , 1);
        
        await NFT.burn(1);

        expect(await NFT.totalSupply() == 0).to.be.true;
       });
       it("Should add Rail", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.mint(deployer , 1);

        await settings.setNetworkSupportedChains([3], ['10000000000000000'] , true);
       
        await bridge.registerRail(NFT , [3] , [NFT] , account2 ,account2);
        console.log(NFT.target);
        console.log(await bridge.nativeAssetsList(0));

        expect(await bridge.nativeAssetsList(0) == NFT.target ).to.be.true;
       });
       
       it("Should Bridge Asset", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.mint(deployer , 1);
        await NFT.approve(bridge.target , 1);

        await settings.setNetworkSupportedChains([3], ['10000000000000000'] , true);
       
        await bridge.registerRail(NFT , [3] , [NFT] , account2 ,account2);
        
        await bridge.activeNativeAsset(NFT , true);
        await bridge.send(3 , NFT , 1 , account3 , { value: "10000000000000000" });
        console.log(await NFT.ownerOf(1));
        console.log(bridge.target );
        expect(await NFT.ownerOf(1) == bridge.target ).to.be.true;
       });

       it("Should register  and validate Asset (mint transaction))", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.transferOwnership(bridge.target);
        
        await settings.setNetworkSupportedChains([3], ['10000000000000000'] , true);
        await bridge.addForiegnAsset( NFT , 3 , false, account2 ,account2 , NFT);
        await controller.addRegistrar(deployer ,true);
        await controller.addOracle(deployer ,true);
        
        console.log( "the NFT: " +NFT.target );
        console.log("the accet: "+ await bridge.wrappedForiegnPair(NFT.target, 3));
      
          const ID = await registry.getID(3 , await bridge.chainId() , NFT.target , 1 , account2 , 0);
        console.log("chain ID : " + await bridge.chainId())
        await registry.registerMintTransaction(ID , 3 , NFT.target , 1 , account2 , 0);
        console.log(await registry.isMintTransaction[ID]);


        await controller.addValidator(deployer ,true);
        await controller.addValidator(account3 ,true);
        
        await registry.validateTransaction(ID , true)
        console.log(await NFT.ownerOf(1));
        expect(await NFT.ownerOf(1)  == account2.address ).to.be.true;

       });

       it("Should register burn  Asset", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.transferOwnership(bridge.target);
        
        await settings.setNetworkSupportedChains([3], ['10000000000000000'] , true);
        await bridge.addForiegnAsset( NFT , 3 , false, account2 ,account2 , NFT);
        await controller.addRegistrar(deployer ,true);
        await controller.addOracle(deployer ,true);
        
        console.log( "the NFT: " +NFT.target );
        console.log("the accet: "+ await bridge.wrappedForiegnPair(NFT.target, 3));
      
          const ID = await registry.getID(3 , await bridge.chainId() , NFT.target , 1 , account2 , 0);
        console.log("chain ID : " + await bridge.chainId())
        await registry.registerMintTransaction(ID , 3 , NFT.target , 1 , account2 , 0);
        console.log(await registry.isMintTransaction[ID]);


        await controller.addValidator(deployer ,true);
        await controller.addValidator(account3 ,true);
       
        console.log("the deployer  is : " + deployer.address)
        await registry.validateTransaction(ID , true)
        console.log(await NFT.ownerOf(1));
        NFT.connect(account2).approve(bridge.target , 1);
        
        await bridge.connect(account2).burn(NFT, 1 ,  deployer ,  { value: "10000000000000000" });

        expect(await NFT.totalSupply() == 0).to.be.true;
       });
     


       it("Should claim Back Bridged Asset", async function () {
        const {controller , registry , feeController,  settings , bridge , deployer , account2 , account3} = await  deployBridge();
        
        const NFTContract  = await ethers.getContractFactory("SimpleNFT");
        const NFT =  await NFTContract.deploy("TETS" , "TFTT" , "1000");
        
        await NFT.mint(deployer , 1);
        await NFT.approve(bridge.target , 1);

        await settings.setNetworkSupportedChains([3], ['10000000000000000'] , true);
       
        await bridge.registerRail(NFT , [3] , [NFT] , account2 ,account2);
        
        await bridge.activeNativeAsset(NFT , true);
        await bridge.send(3 , NFT , 1 , account3 , { value: "10000000000000000" });
        console.log(await NFT.ownerOf(1));
        console.log(bridge.target );
  
        await controller.addRegistrar(deployer ,true);
        await controller.addValidator(deployer ,true);
        await controller.addOracle(deployer ,true);
        const ID = await registry.getID( 3 , await bridge.chainId() , NFT , 1 , account2 , 0);
        await registry.registerClaimTransaction(ID , 3 , NFT , 1 , account2, 0);
        expect(await registry.isClaimTransaction(ID) ).to.be.true;
       });

  });
