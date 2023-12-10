import { writeFileSync } from "fs";
import hre from "hardhat";

async function main() {
  const SwapRouterAddress = {
    scroll: "0x33d91116e0370970444B0281AB117e161fEbFcdD",
    arbitrum: "0x8A21F6768C1f8075791D08546Dadf6daA0bE820c",
  };

  const CURRENT_CHAIN = "arbitrum";

  const sushi = await hre.viem.deployContract("SushiSwapper", [
    SwapRouterAddress[CURRENT_CHAIN],
  ]);

  console.log(
    `Sushi deployed to ${sushi.address} with SwapRouter ${SwapRouterAddress[CURRENT_CHAIN]}`
  );

  writeFileSync("./abis/Sushi.json", JSON.stringify(sushi.abi, null, 4));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
