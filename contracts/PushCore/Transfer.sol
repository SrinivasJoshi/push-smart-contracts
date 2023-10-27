// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library Transfer{
    // @notice This holds the details for a transfer
    struct TransferData {
        address from;
        address to;
        uint256 amount;
    }

    // @notice Transfer an amount of a token to an array of addresses
    // @param _token The address of the token
    // @param _transferData TransferData[]
    // @return Whether the transfer was successful or not
    function _transferAmountsFrom(address _token, TransferData[] memory _transferData,bool isPushToken) internal returns (bool) {
        
        for (uint256 i; i < _transferData.length;) {
            TransferData memory transferData = _transferData[i];
            
            if (isPushToken) {
                //calculate discount for $PUSH
                uint256 _amount;
                bool success;  = IERC20(_token).transferFrom(
                    transferData.from,
                    transferData.to,
                    _amount
                );
                require(success,"Tx failed!");
            } 
            else {
                bool success;  = IERC20(_token).transferFrom(
                    transferData.from,
                    transferData.to,
                    transferData.amount
                );
                require(success,"Tx failed!");
            }
            unchecked {
                ++i;
            }
        }
        return true;
    }

    // @notice Transfer an amount of a token to an address
    // @param _token The address of the token
    // @param _transferData Individual TransferData
    // @return Whether the transfer was successful or not
    function _transferAmountFrom(address _token, TransferData memory _transferData,bool isPushToken) internal returns (bool) {
        if (isPushToken) {
             // CALCULATE DISCOUNT
            uint256 _amount;
            IERC20(_token).transferFrom(
                    _transferData.from,
                    _transferData.to,
                    _amount
                );
        } else {
                IERC20(_token).transferFrom(
                    _transferData.from,
                    _transferData.to,
                    _transferData.amount
                );
        }
        return true;
    }
}