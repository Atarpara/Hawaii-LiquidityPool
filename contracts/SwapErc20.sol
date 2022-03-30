// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SwapErc20 {
    IERC20 Volcano;
    address ownerVulcano;
    IERC20 Honululu;
    address ownerHonululu;

    //example: deploy VolcanoToken with ownerVulcano, after that approve the swap address using ownerVulcano in the VolcanoToken contract
    constructor(
        address _Volcano,
        address _Honululu,
        address _ownerVulcano,
        address _ownerHonululu
    ) {
        Volcano = IERC20(_Volcano);
        Honululu = IERC20(_Honululu);
        ownerVulcano = _ownerVulcano;
        ownerHonululu = _ownerHonululu;
    }

    function swap(uint256 _amount1, uint256 _amount2) public {
        require(
            msg.sender == ownerVulcano || msg.sender == ownerHonululu,
            "not auth"
        );
        require(
            Volcano.allowance(ownerVulcano, address(this)) >= _amount1,
            "Volcano token allowance to low "
        );
        require(
            Honululu.allowance(ownerHonululu, address(this)) >= _amount2,
            "Honululu token allowance to low "
        );

        safeTrasferFrom(Volcano, ownerVulcano, ownerHonululu, _amount1);
        safeTrasferFrom(Honululu, ownerHonululu, ownerVulcano, _amount2);
    }

    function safeTrasferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint256 amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "token trasnfer failed");
    }
}
