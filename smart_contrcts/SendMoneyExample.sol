// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SendMoneyExample {
    address payable public owner;
    bool public isPaused;

    constructor() {
        owner = msg.sender;
    }

    function updateIsPaused(bool _pause) public {
        require(msg.sender == owner, "You are not the owner");
        isPaused = _pause;
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }

    function receiveMoney() public payable {}

    function getOwnerBalance() public view returns (uint256) {
        return owner.balance;
    }

    function getContractAddressBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        require(isPaused == false, "Contact status is currently paused");

        _to.transfer(getContractAddressBalance());
    }

    function destroyContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}
