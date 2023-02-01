// scripts/create-box.js
const { ethers, upgrades } = require("hardhat");

const owner = "";
const token = "";
const fundingGoal = 0;

async function main() {
  const crowdFunding = await ethers.getContractFactory("CrowdFunding");
  const CrowdFunding = await upgrades.deployProxy(crowdFunding, [owner, token, fundingGoal]);
  await CrowdFunding.deployed();
  console.log("CrowdFunding deployed to:", CrowdFunding.address);
  
}

main();