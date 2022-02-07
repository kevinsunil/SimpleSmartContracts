//SPDX-License-Identifier:MIT
pragma solidity >=0.7.0 <0.9.0;

contract SimpleAuction{
    //parameters of the auction
    address payable public beneficiary;
    uint public auctionEndTime;

    //current state of the auction
    address public highestBidder;
    uint public highestBid;

    //mapping to store address and values of bidders who have been outbid so that theirmoney can be returned
    mapping(address => uint) public pendingReturns;

    //to check whether  the auction is going or ended
    bool ended = false;

    // an event which gets emitted each time someone outbids the current bid and an event which emits once the auction is ended
    event highestBidIncreased (address bidder , uint amount);
    event auctionEnded(address winner, uint amount);

    //constructors are always executed first in a contract
    constructor(address payable _beneficiary, uint _biddingTime){
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() public payable{
        if(block.timestamp > auctionEndTime){
            revert("The auction has already ended");
        }
        if(msg.value <= highestBid){
            revert("There is already a higher or equal bid");
        }
        if(highestBid !=0){
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder= msg.sender;
        highestBid = msg.value;
        emit highestBidIncreased(highestBidder, highestBid);
    }

    function withdraw()public returns (bool){
        uint amount = pendingReturns[msg.sender];
        if (amount > 0){
            pendingReturns[msg.sender] =0;
            if(!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }
    function auctionEnd() public{
        if(block.timestamp < auctionEndTime){
            revert("The auction hasn't ended");
        }
        if(ended){
            revert("This function has already being called and the auction is now over");
        }
        ended = true;
        emit auctionEnded(highestBidder , highestBid);
        beneficiary.transfer(highestBid);
    }
}