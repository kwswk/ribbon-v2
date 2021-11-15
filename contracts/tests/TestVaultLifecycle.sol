// SPDX-License-Identifier: MIT
pragma solidity =0.8.4;

import {VaultLifecycle} from "../libraries/VaultLifecycle.sol";
import {Vault} from "../libraries/Vault.sol";

contract TestVaultLifecycle {
    Vault.VaultState public vaultState;

    function getNextFriday(uint256 currentExpiry)
        external
        pure
        returns (uint256 nextFriday)
    {
        return VaultLifecycle.getNextFriday(currentExpiry);
    }

    function balanceOf(address account) public view returns (uint256) {
        if (account == address(this)) {
            return 1 ether;
        }
        return 0;
    }

    function setVaultState(Vault.VaultState calldata newVaultState) public {
        vaultState.totalPending = newVaultState.totalPending;
        vaultState.queuedWithdrawShares = newVaultState.queuedWithdrawShares;
    }

    function rollover(
        uint256 currentSupply,
        address asset,
        uint8 decimals,
        uint256 lastQueuedWithdrawAmount,
        uint256 performanceFee,
        uint256 managementFee
    )
        external
        view
        returns (
            uint256 newLockedAmount,
            uint256 queuedWithdrawAmount,
            uint256 newPricePerShare,
            uint256 mintShares,
            uint256 performanceFeeInAsset,
            uint256 totalVaultFee
        )
    {
        return
            VaultLifecycle.rollover(
                vaultState,
                currentSupply,
                asset,
                decimals,
                lastQueuedWithdrawAmount,
                performanceFee,
                managementFee
            );
    }
}
