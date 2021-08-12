// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses currentStatus;
    event Occupy(address _occupant, uint256 _value);

    address payable public owner;

    constructor() {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant() {
        require(currentStatus == Statuses.Vacant, "Currently occupied!");
        _;
    }

    modifier hasPayedEnough(uint256 amount) {
        require(amount >= amount, "Did not pay enough ether");
        _;
    }

    receive() external payable {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}
