// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {Deploy} from "../script/Deploy.s.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    Deploy public deploy;
    address bob = makeAddr("bob");
    address mia = makeAddr("mia");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deploy = new Deploy();
        ourToken = deploy.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowance() public {
        uint intialAllowance = 1000;

        vm.prank(bob);
        ourToken.approve(mia, intialAllowance);

        uint256 TRANSFER_AMOUNT = 10;

        vm.prank(mia);

        ourToken.transferFrom(bob, mia, TRANSFER_AMOUNT);

        assertEq(ourToken.balanceOf(mia), TRANSFER_AMOUNT);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - TRANSFER_AMOUNT);
    }
}
