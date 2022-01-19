const CryptoZombies = artifacts.require("CryptoZombies");
const utils = require("./helpers/utils");
const zombieNames = ["Zombie 1", "Zombie 2"];

contract("CryptoZombies", (accounts) => {
    let [alice, bob] = accounts;
    let contractInstance;
    beforeEach(async () => {
        contractInstance = await CryptoZombies.new();
    }); //end beforeEach()

    it("should be able to create a new zombie", async () => {
        const contractInstance = await CryptoZombies.new();
        const result = await contractInstance.createRandomZombie(zombieNames[0], {from:  alice});
        assert.equal(result.receipt.status, true);
        assert.equal(result.logs[0].args.name, zombieNames[0]);
    }) //end it()

    it("should not allow two zombies", async () => {
        try {
            //try to create the second zombie
            await contractInstance.createRandomZombie(zombieNames[0], {from: alice});
            await utils.shouldThrow(contractInstance.createRandomZombie);
            assert(true);
        }
        catch (err) {
            return;
        }
        assert(false, "The contract did not throw.");
    }) //end it()
}) //end contract()