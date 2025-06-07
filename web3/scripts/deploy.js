const hre = require("hardhat");

async function main() {
  const CrowdFunding = await hre.ethers.getContractFactory("CrowdFunding");
  const crowdFunding = await CrowdFunding.deploy();

  // Wait for deployment to finish
  await crowdFunding.waitForDeployment();

  // Get deployed address
  const address = await crowdFunding.getAddress();

  console.log(`CrowdFunding deployed to ${address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});