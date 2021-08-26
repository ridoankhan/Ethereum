var AnikToken = artifacts.require("AnikToken.sol");

module.exports = async function (deployer) {
  await deployer.deployer(AnikToken, 1000000);
};
