pragma solidity ^0.5.16;

contract Election {
    
    // Model the Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store and fetch Candidates
    mapping(uint => Candidate) public candidates;

    // Store Candidates count
    uint public candidatesCount;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    // Constructor
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that the voter has not voted before
        require(!voters[msg.sender]);

        // candidateId is valid
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        
        // record that voter has voted
        voters[msg.sender] = true;

        // update the candidate's vote count
        candidates[_candidateId].voteCount++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}