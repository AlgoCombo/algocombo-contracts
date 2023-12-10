import hre from "hardhat";

async function main() {
  const SwapRouterAddress = {
    scroll: "0x33d91116e0370970444B0281AB117e161fEbFcdD",
  };

  const CURRENT_CHAIN = "scroll";

  const sushi = await hre.viem.deployContract("SushiSwapper", [
    SwapRouterAddress[CURRENT_CHAIN],
  ]);

  console.log(
    `Sushi deployed to ${sushi.address} with SwapRouter ${SwapRouterAddress[CURRENT_CHAIN]}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
