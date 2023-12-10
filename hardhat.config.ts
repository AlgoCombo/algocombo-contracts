import "dotenv/config";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const PRIVATE_KEY = process.env.PERSONAL_PRIVATE_KEY || "";
const accounts = [`0x${PRIVATE_KEY}`];

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    polygon: {
      accounts,
      url: "https://polygon-mainnet.g.alchemy.com/v2/AF2A5lTVs_Uh_Zkk-BF-n91QH5F1FH47",
    },
    scroll: {
      accounts,
      url: "https://rpc.scroll.io",
    },
    arbitrum: {
      accounts,
      url: "https://arbitrum.llamarpc.com",
    },
  },
};

export default config;
