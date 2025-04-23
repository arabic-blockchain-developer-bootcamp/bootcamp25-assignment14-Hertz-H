// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;
    //makeAddr accepts string and generate etheruim address //instead of the real wallet address
    address user = makeAddr("user");

//setUp function runs before each test function
    function setUp() public {
        // TODO: instantiate new instance of the Vault contract
        vault = new Vault();

        // TODO: Fund the user with some ether using vm.deal instead of the fundin faustes to the real wallet 
        vm.deal(user,10 ether);
 
    }

    function testDeposit() public {
        //foundry provides vm.prank(user) make message.sender = user address 
        //specify the address of the user that you want to call the direct next function
        // TODO: prank user and call deposit with 1 ether 
       vm.prank(user);
       // this will call the deposit with message.sender = user  address
       //the user of the prank will call the deposite
        vault.deposit{ value: 1 ether}();
        assertEq(vault.balances(user), 1 ether);
    }

    function testWithdraw() public {
        // TODO: prank user, deposit 2 ether, withdraw 1 ether
        //instead of duplicating the prank() we use the start and stop if we have multiple transctionss
        vm.startPrank(user);
//ensure that you have 2 ether in your wallet before deposite to your balance in the contract
        vault.deposit{ value: 2 ether }();
        vault.withdraw(1 ether);

        vm.stopPrank();

        assertEq(vault.balances(user), 1 ether);
    }
// sad scenario to test that the operation willnot work if the condition is not met
    function test_RevertWithdrawMoreThanBalance() public {
      // TODO: prank user, deposit 1 ether
        vm.startPrank(user);
        vault.deposit{ value: 1 ether}();
      //used before the function that you expect it to revert Now i expect the withdrow to revert
        vm.expectRevert();
        // TODO: try to withdraw 2 ether
        vault.withdraw(2 ether);
        vm.stopPrank();


    }

    function testGetBalance() public {
        // TODO: prank user, deposit 0.5 ether, check getBalance
        vm.startPrank(user);
        vault.deposit{ value: 0.5 ether }();
        uint256 balance =vault.getBalance();
        vm.stopPrank();
        // TODO: assert returned balance is 0.5 
        assertEq(balance,0.5 ether);
    }
}
