// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract DelegateCaller {
  address EventContract;

  constructor() {
  }

  function setEventContractAddress(address _address) public {
    EventContract = _address;
  }

  function delegateCall() public {
    require(EventContract != address(0), "`EventContract` address has not been set");
    
    (bool success, bytes memory data) = EventContract.delegatecall(
      abi.encodeWithSignature("triggerEvent()"));

    require(success, "delegatecall failed");
  }
}

contract EventEmitter {
  event DelegatedEvent();

  function triggerEvent() public {
    emit DelegatedEvent();
  }
}
