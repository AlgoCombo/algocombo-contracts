import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox-viem/network-helpers";
import { expect } from "chai";
import hre from "hardhat";
import { getAddress, parseGwei } from "viem";

describe("Sushi", function () {
  async function setup() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await hre.viem.getWalletClients();

    const sushi = await hre.viem.deployContract("SushiSwapper", [
      "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506",
    ]);

    const publicClient = await hre.viem.getPublicClient();

    return {
      sushi,
      publicClient,
    };
  }

  describe("Swap on Polygon", function () {
    it("Should swap", async function () {
      const { sushi, publicClient } = await loadFixture(setup);
    });
  });
});
