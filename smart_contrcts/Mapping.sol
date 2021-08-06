// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Mapping {
    mapping(uint256 => string) public names;

    constructor() {
        names[1] = "Ridoan";
        names[2] = "Naushad";
        names[3] = "Minul";
    }

    // Use struct with mapping
    mapping(uint256 => Book) public books;

    struct Book {
        uint256 bookNumber;
        string title;
        string author;
    }

    function addBook(
        uint8 _id,
        uint8 bookNo,
        string memory bookTitle,
        string memory bookAuthor
    ) public {
        books[_id] = Book(bookNo, bookTitle, bookAuthor);
    }
}
