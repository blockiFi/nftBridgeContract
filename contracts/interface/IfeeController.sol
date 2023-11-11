// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

interface IfeeController {
    function getBridgeFee(address sender, address asset, uint256 chainTo ) external view returns (uint256);

}