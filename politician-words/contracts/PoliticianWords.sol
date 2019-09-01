pragma solidity ^0.4.17;

contract PoliticianWords {
    address public owner;
    address[] public voters;
    string public claim;
    string public content;
    string public status;
    string public totalVotes;

    // when politicians stand for elections, they make claims
    // they have to put money where their mouth is and create
    // a contract for each claim

    // whenever politicians don't fulfill their claims,
    // voters can vote on the contract in order to forfeit
    // the ether put up and distribute it among the voters
    
    // whenever politicians fulfill their claims,
    // voters can vote on the contract and ether can be
    // sent to the politician

    // the politician will be the owner of this contract
    function PoliticianWords() public {
        owner = msg.sender;
    }

    function setContent(string initialContent) public {
        content = initialContent;
    }

    // require 0.05 ether everytime a politician makes a claim
    function submitClaim(string initialClaim) public payable restricted {
        require(msg.value >= .05 ether);
        claim = initialClaim;
        totalVotes = '88';
        status = "Open";
    }

    function getClaim() public view returns (string) {
        return claim;
    }

    function getContent() public view returns (string) {
        return content;
    }

    function getStatus() public view returns (string) {
        return status;
    }

    // require 0.01 ether for voters to vote. nothing more
    // nothing less
    function vote() public payable {
        require(msg.value == .01 ether);
        require(msg.sender != owner);
        
        voters.push(msg.sender);
    }

    // return the list of voters who voted for the politician
    // with their ethers
    function getVoters() public view returns (address[]) {
        return voters;
    }

    // if the voters have agreed that the politician has 
    // achieved his claim, send all the ether in the balance
    // to the politician
    function achieveClaim() public {
        owner.transfer(this.balance);
    }

    // if the voters have disagreed that the politician has
    // achieved his claim, send all the ether in the balance
    // equally to each voter's account
    function failClaim() public {
        uint votersLength = voters.length;
        uint amountToTransfer = this.balance / votersLength;
        for (uint i=0; i<votersLength; i++) {
            voters[i].transfer(amountToTransfer);
        }
    }

    // get total amount stored in contract
    function getBalance() public view returns (uint) {
        return this.balance;
    }

    modifier restricted() {
        require(msg.sender == owner);
        _;
    }

}