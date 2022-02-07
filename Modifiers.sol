//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

contract SimpleCoin{ 
    address public minter;
    mapping(address => uint) public balances;
    event Sent(address from, address to, uint amount);
    //it's important to end modifier with _; modifier is used to check a condition prior to executing a function.
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
    }
    function mint(address receiver, uint amount) public onlyMinter amountLesserThan(amount) {
        balances[receiver] += amount; 
    }
    function send(address receiver, uint amount) public balanceCheck(amount){
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
} 