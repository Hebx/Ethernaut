pragma solidity ^0.8.0;

contract DaoWallet{
    mapping(address => uint) public balances;
    // mutex
    bool internal locked;

    modifier noReeantrancy() {
        require(!locked, "No Reeantrancy");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    function withdraw(uint _amount) public noReeantrancy {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Transaction failed");

    }
    function accountBalance() public view returns (uint) {
        return address(this).balance;
    }
}
