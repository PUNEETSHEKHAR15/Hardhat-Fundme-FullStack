require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-waffle");
require("dotenv").config()
require("hardhat-deploy")
require("hardhat-gas-reporter")
require("solidity-coverage")
/** @type import('hardhat/config').HardhatUserConfig */
const Sepolia_private_key = process.env.SEPOLIA_PRIVATE_KEY || "28de8e51dd74e340f2f946ffb73ceccb5bfd47177a28750dac554c7e8e5bfca7";
const sepolia_rpc_url = process.env.RPC_URL || "https://eth-sepolia.g.alchemy.com/v2/bo86pS8QhKW7iBD7cKOMxWuHIBqOTS_4";

module.exports = {
  defaultNetwork: "hardhat",
  Networks: {
    hardhat: {
      chainId: 31337,
    },
    sepolia: {
      url: sepolia_rpc_url,
      accounts: [Sepolia_private_key],
      chainId: 11155111,
      blockconfirmations: 6,
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.8",
      },
      {
        version: "0.6.6",
      },
    ],
  },
  gasReporter: {
    enabled: true,
    currency: "USD",
    outputFile: "gas-reporter.txt",
    nocolor: true,
  },

}
