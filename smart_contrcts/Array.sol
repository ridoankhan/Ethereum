// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Array {
    uint256[] public numbers = [300, 400, 500];

    string[] public value;

    string[] public fruits = ["apple", "banana", "carrot"];

    uint256[][] public array2D = [[1, 2, 3], [4, 5, 6]];

    function addElements(string memory _value) public {
        value.push(_value);
    }

    function countLength() public view returns (uint256) {
        return fruits.length;
    }
}
