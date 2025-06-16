const hre = require("hardhat");

async function main() {
  console.log("Deploying NADToken...");
  
  // Get the signer
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying from address:", deployer.address);
  
  // Get the balance
  const balance = await deployer.provider.getBalance(deployer.address);
  console.log("Account balance:", hre.ethers.formatEther(balance), "MATIC");

  try {
    const NADToken = await hre.ethers.getContractFactory("NADToken");
    
    console.log("Deploying contract...");
    const deployment = await NADToken.deploy();
    
    console.log("Waiting for deployment transaction...");
    const deployTx = await deployment.deploymentTransaction();
    if (!deployTx) {
      throw new Error("Deployment transaction not found");
    }
    
    console.log("Deployment transaction hash:", deployTx.hash);
    console.log("Waiting for deployment confirmation...");
    
    await deployment.waitForDeployment();
    const address = await deployment.getAddress();
    console.log(`NADToken deployed to: ${address}`);

    // Verify the contract on Etherscan
    if (process.env.POLYGONSCAN_API_KEY) {
      console.log("Waiting for block confirmations...");
      await deployTx.wait(6); // Wait for 6 block confirmations

      console.log("Verifying contract...");
      try {
        await hre.run("verify:verify", {
          address: address,
          constructorArguments: [],
        });
        console.log("Contract verified successfully");
      } catch (error) {
        console.log("Error verifying contract:", error);
      }
    }
  } catch (error) {
    console.error("Deployment failed!");
    console.error("Error details:", error.message);
    if (error.data) {
      console.error("Error data:", error.data);
    }
    process.exit(1);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 