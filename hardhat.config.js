require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');
const {mnemonic } = require("./secret.json")
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
 
    solidity: {
    compilers: [
      {
        version: "0.8.19",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      },
    ]

    },
    networks: {
      bsc: {
        url: "https://green-aged-panorama.bsc-testnet.quiknode.pro/0063b84f1631faf4d8cd6789fa84d7df2b2d1e2c/",
      chainId : 97,
      accounts: {mnemonic : mnemonic},
    },
    opbnb: {
      url: "https://opbnb-testnet-rpc.bnbchain.org",
    chainId : 5611,
    accounts: {mnemonic : mnemonic},
  }
  },
  etherscan: {
    // apiKey: "D8M63Z5KSJ3583F5S7194GJG5N38CJQXQH" //bsc
    // apiKey: "81291aeefc084880903da2329ae0d3bb" //
    // apiKey: "SBWKPGB4NEXEZWWIPPWMRV5QY3WMH8271C" //polygon
    // apiKey: "WC9BP5TQVJUKDP63KED42ZQKNM7NC5HA6U" //eth
    // apiKey: "PZUXVNQZ662DPURSEEZTGUG7GY2MBI853U"// opt
    // apiKey: "RG54X18EJKVTVADRCD28FXQEY3Q7DJ6G4C"// arb
    // apiKey: ""// kcc
    // apiKey: "KXN1I8PNITSUARNZ398W4TV4W93YN8ZIY1"// ftm
    // apiKey: ""// avax


//     controllerContract deployed at: 0xA6f825d5D2c3744948Ccbabc21126Ba014648051
// Settings contract  deployed at: 0xE6e3112ab4A376CBEF510e4d2D601e3E4224039D
// feeController contract  deployed at: 0x3395330383BcF5DAc53D67414D2E07cbb58359Fb
// registry contract  deployed at: 0x986029CF0DCA1bC283c30A26986aae22bAcE9932
// bridgeContract contract  deployed at: 0xE4983ad8E65D6A9F89379FD049F17E0bBB14FBF0
// nft contract  deployed at: 0x9AB76119fB6253E4Ed7dcB93E69b37b793c7B3B2
    apiKey: {
      // opbnb: "81291aeefc084880903da2329ae0d3bb"
      bscTestnet:"D8M63Z5KSJ3583F5S7194GJG5N38CJQXQH"
    },

    customChains: [
      {
       network: "opbnb",
       chainId: 5611, // Replace with the correct chainId for the "opbnb" network
       urls: {
         apiURL:  "https://open-platform.nodereal.io/81291aeefc084880903da2329ae0d3bb/op-bnb-testnet/contract/",
         browserURL: "https://opbnbscan.com/",
       },
      },
     ]
  },



  
};
