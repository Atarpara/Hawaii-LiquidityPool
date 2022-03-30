// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SwapErc20 {
    IERC20 Volcano;
    address ownerVulcano;
    IERC20 Honululu;
    address ownerHonululu;

    // token price for ETH
    uint256 public tokensPerEth = 100;

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

    function buyVolcano() public payable returns (uint256 tokenAmount) {
        require(msg.value > 0, "Send ETH to buy some tokens");

        uint256 amountToBuy = msg.value * tokensPerEth;

        // check if the Vendor Contract has enough amount of tokens for the transaction
        uint256 vendorBalance = Volcano.balanceOf(address(this));
        require(
            vendorBalance >= amountToBuy,
            "Vendor contract has not enough tokens in its balance"
        );

        // Transfer token to the msg.sender
        bool sent = Volcano.transfer(msg.sender, amountToBuy);
        require(sent, "Failed to transfer token to user");

        return amountToBuy;
    }

    function buyHonululu() public payable returns (uint256 tokenAmount) {
        require(msg.value > 0, "Send ETH to buy some tokens");

        uint256 amountToBuy = msg.value * tokensPerEth;

        // check if the Vendor Contract has enough amount of tokens for the transaction
        uint256 vendorBalance = Honululu.balanceOf(address(this));
        require(
            vendorBalance >= amountToBuy,
            "Vendor contract has not enough tokens in its balance"
        );

        // Transfer token to the msg.sender
        bool sent = Volcano.transfer(msg.sender, amountToBuy);
        require(sent, "Failed to transfer token to user");

        return amountToBuy;
    }
}
