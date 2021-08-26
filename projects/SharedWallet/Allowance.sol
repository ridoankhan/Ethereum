//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "./libraries/Ownable.sol";
import "./libraries/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public allowance;

    event AllowanceChanged(
        address indexed _forWho,
        address indexed fromWhom,
        uint256 oldBalance,
        uint256 newBalance
    );

    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed!"
        );
        _;
    }

    function setAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint256 _amount)
        internal
        ownerOrAllowed(_amount)
    {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] = allowance[_who].sub(_amount);
    }
}
