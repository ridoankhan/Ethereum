//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Ownable {
    address public _owner;

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    function isOwner() public view returns (bool) {
        return (msg.sender == _owner);
    }
}

contract Item {
    uint256 public priceInWei;
    uint256 public paidWei;
    uint256 public index;

    ItemManager parentContract;

    constructor(
        ItemManager _parentContract,
        uint256 _priceInWei,
        uint256 _index
    ) {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        require(msg.value == priceInWei, "We don't support partial payments");
        require(paidWei == 0, "Item is already paid!");
        paidWei += msg.value;
        (bool success, ) = address(parentContract).call{value: msg.value}(
            abi.encodeWithSignature("triggerPayment(uint256)", index)
        );
        require(success, "Delivery did not work");
    }

    fallback() external {}
}

contract ItemManager is Ownable {
    enum SupplyChainSteps {
        Created,
        Paid,
        Delivered
    }

    struct S_Item {
        Item _item;
        string _identifier;
        uint256 _priceInWei;
        ItemManager.SupplyChainSteps _step;
    }

    mapping(uint256 => S_Item) public items;

    event SupplyChainStep(uint256 _itemIndex, uint256 step, address _address);

    uint256 index;

    function createItem(string memory _identifier, uint256 _priceInWei)
        public
        onlyOwner
    {
        Item item = new Item(this, index, _priceInWei);
        items[index]._item = item;
        items[index]._identifier = _identifier;
        items[index]._priceInWei = _priceInWei;
        items[index]._step = SupplyChainSteps.Created;
        index++;
    }

    function triggerPayment(uint256 _index) public payable onlyOwner {
        Item item = items[_index]._item;

        require(
            address(item) == msg.sender,
            "Only items are allowed to update themselves"
        );
        require(item.priceInWei() == msg.value, "Not fully paid yet");
        require(
            items[index]._step == SupplyChainSteps.Created,
            "Item is further in the supply chain"
        );

        items[_index]._step = SupplyChainSteps.Paid;

        emit SupplyChainStep(
            _index,
            uint256(items[_index]._step),
            address(item)
        );
    }

    function triggerDelivery(uint256 _index) public {
        require(
            items[_index]._step == SupplyChainSteps.Paid,
            "Item is not available for delivery"
        );

        items[_index]._step = SupplyChainSteps.Delivered;
        emit SupplyChainStep(
            _index,
            uint256(items[_index]._step),
            address(items[_index]._item)
        );
    }
}
