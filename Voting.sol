// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    // 🔒 Modifier for admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    // Jury system
    mapping(address => bool) public isJury;
    mapping(address => uint) public juryVotes;

    // Track if jury already voted for a candidate
    mapping(address => mapping(uint => bool)) public hasVoted;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;

    // 📢 Events (VERY IMPORTANT)
    event CandidateAdded(string name);
    event JuryAdded(address jury);
    event Voted(address jury, uint candidateIndex);

    // Add candidate
    function addCandidate(string memory name) public onlyAdmin {
        candidates.push(Candidate(name, 0));
        emit CandidateAdded(name);
    }

    // Add jury
    function addJury(address jury) public onlyAdmin {
        require(!isJury[jury], "Already jury");

        isJury[jury] = true;
        juryVotes[jury] = 10;

        emit JuryAdded(jury);
    }

    // Vote
    function vote(uint candidateIndex) public {
        require(isJury[msg.sender], "Not a jury");
        require(juryVotes[msg.sender] > 0, "No votes left");
        require(candidateIndex < candidates.length, "Invalid candidate");
        require(!hasVoted[msg.sender][candidateIndex], "Already voted for this candidate");

        candidates[candidateIndex].voteCount += 1;
        juryVotes[msg.sender] -= 1;
        hasVoted[msg.sender][candidateIndex] = true;

        emit Voted(msg.sender, candidateIndex);
    }

    // Get all candidates
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    // Votes left
    function getVotesLeft(address jury) public view returns (uint) {
        return juryVotes[jury];
    }
}
