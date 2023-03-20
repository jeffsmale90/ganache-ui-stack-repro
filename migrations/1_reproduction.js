var DelegateCaller = artifacts.require("DelegateCaller");

// remove this for run 2
var EventEmitter = artifacts.require("EventEmitter");

module.exports = async function (deployer, network, accounts) {
  // Run 1
  await deployer.deploy(EventEmitter);
  /*

  // Run 2
  await deployer.deploy(DelegateCaller);
  const delegateCaller = await DelegateCaller.deployed();

  await delegateCaller.setEventContractAddress(
    // update this to the EventEmitter address from run 1
    "<event-emitter-address>"
  );

  await delegateCaller.delegateCall();*/
};
