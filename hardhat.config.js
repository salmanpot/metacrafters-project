require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');

const {
  BSC_TESTNET_URL,
  BSC_TESTNET_DEPLOY_KEY,
  BSCSCAN_API_KEY,
} = require("./env.json")

module.exports = {
  networks: {
    bscTestnet: {
      url: BSC_TESTNET_URL,
      chainId: 97,
      gasPrice: 20000000000,
      accounts: [BSC_TESTNET_DEPLOY_KEY]
    }
  },
  etherscan: {
    apiKey: {
      bscTestnet: BSCSCAN_API_KEY
    }
  },
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1
      }
    }
  }
}
