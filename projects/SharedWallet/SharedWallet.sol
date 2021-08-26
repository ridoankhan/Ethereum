/*
Anyone can deposit in the contract

Owner can withdraw all ether from contract to a specific address

Non-owner can withdraw ether depending on the allowance to specific address and specific amount

Owner can change allowance for a specific address

*/

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "./Allowance.sol";

contract SharedWallet is Allowance {
    event MoneySent(address indexed _to, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

    function withdraw(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            address(this).balance >= _amount,
            "Contract does not have enough balance"
        );

        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }

    function renounceOwnership() public view override onlyOwner {
        revert("can't renounce Ownership in this smart contract"); //not possible with this smart contract
    }
}
