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
    uint public prices;

    address public buyer;
    address payable public 

    //MODIFIERS

    modifier onlyBuyer(){
        require();
    }

    //FUNCTIONS

    constructor(){

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