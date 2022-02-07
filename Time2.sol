//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

contract SimpleCoin{
    uint contractStartTime; 
    address public minter;
    mapping(address => uint) public balances;
    event Sent(address from, address to, uint amount);
    modifier onlyMinter{
        require(msg.sender == minter, "only minter can mint the tokens");
        _;
    }
    modifier amountLesserThan(uint amount){
        require(amount < 1e60);
        _;
    }
    modifier balanceCheck(uint amount){
        require(amount <= balances[msg.sender],"Insuffiecient Balance");
        _;
    }
    constructor(){
        minter =msg.sender;
        contractStartTime = block.timestamp;
    }
    function mint(address receiver, uint amount) public onlyMinter amountLesserThan(amount) {
        balances[receiver] += amount; 
    }
    function send(address receiver, uint amount) public balanceCheck(amount){
        require(block.timestamp >= contractStartTime + 604800);
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
} 