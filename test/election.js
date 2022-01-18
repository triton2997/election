var Election = artifacts.require('./Election.sol')

contract("Election", function(accounts) {
    
    var electionInstance;

    it("initializes with two candidates", function() {
        return Election.deployed().then(function(instance) {
            return instance.candidatesCount();
        }).then(function(count) {
            assert.equal(count, 2);
        });
    });

    it("initializes the candidates with the right values", function() {
        return Election.deployed().then(function(instance) {
            electionInstance = instance;
            return electionInstance.candidates(1);
        }).then(function(candidate) {
            assert.equal(candidate.id, 1, "contains the correct id");
            assert.equal(candidate.name, "Candidate 1", "contains the correct name");
            assert.equal(candidate.voteCount, 0, "contains the correct vote count");
            return electionInstance.candidates(2);
        }).then(function(candidate) {
            assert.equal(candidate.id, 2, "contains the correct id");
            assert.equal(candidate.name, "Candidate 2", "contains the correct name");
            assert.equal(candidate.voteCount, 0, "contains the correct vote count");
        });
    });
});