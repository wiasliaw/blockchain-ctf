// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "./Instance.sol";

contract Clear is Test {
    Instance private _instance;
    address payable private _player;

    function testLocal() external {
        _instance = new Instance("hello world");
        _instance.authenticate(_instance.password());
        assertTrue(_instance.getCleared());
    }

    function testFork() external {
        vm.createSelectFork(vm.rpcUrl("rinkeby"));
        _instance = Instance(vm.envAddress("HELLO_ETHERNAUT"));
        _player = payable(vm.envAddress("PLAYER"));

        vm.startPrank(_player);
        _instance.authenticate(_instance.password());
        assertTrue(_instance.getCleared());
        vm.stopPrank();
    }

    function run() external {
        _instance = Instance(vm.envAddress("HELLO_ETHERNAUT"));
        _player = payable(vm.envAddress("PLAYER"));

        vm.startBroadcast();
        _instance.authenticate(_instance.password());
        assertTrue(_instance.getCleared());
        vm.stopBroadcast();
    }
}
