// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Vault {
    //public states variales can be treated as function 
    mapping(address => uint256) public balances;

    // Deposit ETH into the vault
    function deposit() external payable {
        require(msg.value > 0, "Must send some ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw ETH from the vault
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send ETH");
    }

    // Get balance of caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
