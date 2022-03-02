//SPDX-License-Identifier:MIT
pragma solidity >= 0.7.0 <0.9.0;
contract BlindAuction{
    
    //VARIABLES

    struct Bid{
        bytes32 blindedBid;
        uint deposit;
    }

    address payable public beneficiary;
    address public highestBidder;
    uint public biddingEnd;
    uint public revealEnd;
    uint public highestBid;
    bool public ended;

    mapping(address => Bid[]) public bids;
    mapping (address => uint) pendingReturns;

    //EVENTS

    event AuctionEnded(address winner, uint higheestBid);

    //Modifiers

    modifier onlyBefore(uint _time){
        require(block.timestamp < _time);
        _;
    }
    modifier onlyAfter(uint _time){
        require(block.timestamp > _time);
        _;
    }

    //FUNCTIONS

    constructor(uint _biddingTime, uint _revealTime, address payable _beneficiarry){
      beneficiary = _beneficiarry;  
      biddingEnd = block.timestamp + _biddingTime;
      revealEnd = biddingEnd + _revealTime;
    }
    function generateBlindedBidBytes32(uint value, bool fake) public view returns (bytes32){
        return keccak256(abi.encodePacked(value, fake));
    }
    function bid(bytes32 _blindedBid) public payable {

    }

    function withdraw() public {
        uint amount  = pendingReturns[msg.sender];
        if(amount > 0){
            pendingReturns[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        }
    }
    function placeBid(){

    }
    function auctionEnd(){

    }
    function reveal(){

    }
}