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

    function initContract() escrowNotStarted public{
        if(msg.sender == buyer){
            isBuyerIn = true;
        }
        if(msg.sender == seller){
            isSellerIn = true;
        }
        if(isBuyerIn && isSellerIn){
            current_State = state.AWAITING_PAYEMENT;
        }
    }

    function deposit() onlyBuyer public payable{
        require(current_State == state.AWAITING_PAYEMENT, "Already Paid");
        require(msg.value == price, "wrong deposit");
        current_State =state.AWAITING_DELIVERY;
    }

    function confirmDelivery() onlyBuyer payable public{
        require(current_State == state.AWAITING_DELIVERY, "Cannot confirm delivery");
        seller.transfer(price);
        current_State = state.COMPLETE;
    }
    function withdraw() onlyBuyer payable public{
        require(current_State== state.AWAITING_DELIVERY, "Cannot withdraw at this stage");
        payable(msg.sender).transfer(price);
        current_State = state.COMPLETE;
    }
}
