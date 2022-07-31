// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract BuyMeACoffee {
    address payable owner;
    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    function buyCoffee(string calldata _name, string calldata _message)
        public
        payable
    {
        require(msg.value > 0, "can't buy coffee for free");
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}
