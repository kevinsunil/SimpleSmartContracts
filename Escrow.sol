//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

contract Escrow{
    //VAARIABLES
    enum state{
        NOT_INITIATED, AWAITING_PAYEMENT, AWAITING_DELIVERY,COMPLETE
    }

    state public current_State;
    bool public isBuyerIn;
    bool public isSellerIn;
    uint public price;

    address public buyer;
    address payable public seller; 

    //MODIFIERS

    modifier onlyBuyer(){
        require(msg.sender == buyer, "only buyer can call this function");
        _;
    }

    modifier escrowNotStarted(){
        require(current_State == state.NOT_INITIATED);
        _;
    }


    //FUNCTIONS

    constructor(address _buyer, address payable _seller, uint _price){
        buyer = _buyer;
        seller =_seller;
        price = _price * (1 ether);
    }

    function initContract(){

    }

    function deposit(){

    }

    function confirmDelivery(){

    }
    function withdraw(){

    }
}