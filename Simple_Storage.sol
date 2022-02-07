//SPDX-License-Identifier:MIT
pragma solidity >=0.4.16 <0.9.0;

contract SimpleStorage{
    uint storedData;
    // A simple smart contract to store a dta from the user and to display it . Can be used in the smart contracts where 
    // the listing price for assets needs to be stored and displayed temporarily or in transactions to show the amount being transferred
    function set(uint x) public{
        storedData = x;
    }

    function get() public view returns(uint){
        //the keyword view ensures that the function doesn't change the state of the variable,data or contract
        return storedData;
    }
}