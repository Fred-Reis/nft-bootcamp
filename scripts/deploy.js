const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed at: ", nftContract.address);

  let txn = await nftContract.makeAnEpicNFT();

  await txn.wait();
  console.log(`NFT #1 has minted!`);

  txn = await nftContract.makeAnEpicNFT();

  await txn.wait();
  console.log(`NFT #2 has minted!`);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
};

runMain();
