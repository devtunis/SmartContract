// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    
    address public admin;

    constructor() {
        admin = msg.sender;
    }

   
    mapping(address => bool) public isJury;
    mapping(address => uint) public juryVotes;

  
    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;
 
    function addCandidate(string memory name) public {
        require(msg.sender == admin, "Only admin");
        candidates.push(Candidate(name, 0));
    }

  
    function addJury(address jury) public {
        require(msg.sender == admin, "Only admin");

        isJury[jury] = true;
        juryVotes[jury] = 10;
    }

 
    function vote(uint candidateIndex) public {
        require(isJury[msg.sender], "Not a jury");
        require(juryVotes[msg.sender] > 0, "No votes left");
        require(candidateIndex < candidates.length, "Invalid candidate");

        candidates[candidateIndex].voteCount += 1;
        juryVotes[msg.sender] -= 1;
    }

   
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

  
    function getVotesLeft(address jury) public view returns (uint) {
        return juryVotes[jury];
    }
}
