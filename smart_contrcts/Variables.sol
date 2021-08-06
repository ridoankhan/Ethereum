// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

contract Variables {
    uint256 public myUint;

    function setMyUint(uint256 _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;

    function setBoolean(bool newBool) public {
        myBool = newBool;
    }

    uint8 public myUint8;

    function incrementUint() public {
        myUint8++;
    }

    function decrementUint() public {
        myUint8--;
    }

    address public myAddress;

    function setAddress(address _address) public {
        myAddress = _address;
    }

    function getMyAddressBalance() public view returns (uint256) {
        return myAddress.balance;
    }

    string myString;

    function setMyString(string memory newString) public {
        myString = newString;
    }

    struct Person {
        uint256 age;
        string name;
    }

    Person public person = Person(27, "Ridoan Khan Anik");
}
