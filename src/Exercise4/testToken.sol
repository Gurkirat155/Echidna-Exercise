// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract testToken is Token {
    
    function transfer(address to, uint256 value) public override{
        uint256 intialBalOfSender = balances[msg.sender];
        uint256 intialBalOfReciever = balances[to];
        super.transfer(to,value);
        assert(intialBalOfSender >= balances[msg.sender]);
        assert(intialBalOfReciever <= balances[to]);
    }
}