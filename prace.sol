// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import {FtsoV2Interface} from "@flarenetwork/flare-periphery-contracts/coston2/FtsoV2Interface.sol";
import {IFeeCalculator} from "@flarenetwork/flare-periphery-contracts/coston2/IFeeCalculator.sol";

contract Prace {

    FtsoV2Interface internal ftsoV2;
    IFeeCalculator internal feeCalc;
    bytes21[] public feedIds;
    bytes21 public flrUsdId;
    uint256 public fee;


    constructor() {
        
        
        ftsoV2 = FtsoV2Interface(0x3d893C53D9e8056135C26C8c638B76C8b60Df726);
        feeCalc = IFeeCalculator(0x88A9315f96c9b5518BBeC58dC6a914e13fAb13e2);
        flrUsdId = 0x01464c522f55534400000000000000000000000000;
        feedIds.push(flrUsdId);
    }


    function setPeripherals(address _ftsoV2, address _feeCalc, bytes21 _flrUsdId) public {
        ftsoV2 = FtsoV2Interface(_ftsoV2);
        feeCalc = IFeeCalculator(_feeCalc);
        flrUsdId = _flrUsdId;
    }

    function checkFees() external returns (uint256 _fee) {
        fee = feeCalc.calculateFeeByIds(feedIds);
        return fee;
    }

    function getFlrUsdPrice() external payable returns (uint256, int8, uint64) {
        (uint256 feedValue, int8 decimals, uint64 timestamp) = ftsoV2.getFeedById{value: msg.value}(flrUsdId);

        return (feedValue, decimals, timestamp);
    }






}

