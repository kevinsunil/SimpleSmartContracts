//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

contract SimpleCoin{
    //The contract is to mint a token or a crypto. the address data type is used to store the address of a crypto wallet.
    // Here in this case it stores the address of the one calling the contract that i.e the one minting the crypto using msg.sender.
    //mapping is like linked list here it is used such that the wallet address is the key and the uint will be the balance in it. 
    address public minter;
    mapping(address => uint) public balances;
    event Sent(address from, address to, uint amount);
    constructor(){
        minter =msg.sender;
    }
    function mint(address receiver, uint amount) public{
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount; 
    }
    function send(address receiver, uint amount) public{
        require(amount <= balances[msg.sender],"Insuffiecient Balance");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}