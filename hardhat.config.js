require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const PRIVATE_KEY = process.env.PRIVATE_KEY?.startsWith('0x') 
  ? process.env.PRIVATE_KEY 
  : `0x${process.env.PRIVATE_KEY}`;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    testnet: {
      url: process.env.TESTNET_RPC_URL || "https://rpc-amoy.polygon.technology/",
      accounts: [PRIVATE_KEY],
      gasPrice: 35000000000,
      gas: 2100000,
      chainId: 80002  // Amoy testnet chain ID
    },
    polygon: {
      url: process.env.POLYGON_RPC_URL || "https://polygon-rpc.com",
      accounts: [PRIVATE_KEY],
      gasPrice: 35000000000,
      gas: 2100000,
      chainId: 137
    }
  },
  etherscan: {
    apiKey: {
      polygon: process.env.POLYGONSCAN_API_KEY,
      polygonMumbai: process.env.POLYGONSCAN_API_KEY
    }
  }
}; 