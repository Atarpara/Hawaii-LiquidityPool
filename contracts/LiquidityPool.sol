// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity ^0.8.4;

contract LiquidityPool{
    using SafeMath for uint256;

    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    mapping(address => uint) public _balances;
    uint _totalSupply;

    //constant price for testing: price = tokenA/tokenB
    uint public price = 2;

    constructor(address _tokenA, address _tokenB){
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    /*--------VIEW FUNCTIONS--------*/

    function getBalance(address _address) public view returns (uint){
        return _balances[_address];
    }

    function getTotalSupply() public view returns (uint){
        return _totalSupply;
    }

    /*Returns price of tokenA/tokenB in wei
    If tokenA = $5, tokenB = $10
    then: tokenA supply: tokenB supply = 2:1
    returns 1/2 = 0.5 */
    function getPriceRatio() public view returns (uint){
        
        return tokenB.balanceOf(address(this)).mul(1e18).div(tokenA.balanceOf(address(this)));
    }

    /*--------MUTATIVE FUNCTIONS--------*/

    function swap(address _tokenIn, uint _amountIn) external{
        require(
            _tokenIn == address(tokenA) || _tokenIn == address(tokenB),
            "invalid token"
        );

        if (_tokenIn == address(tokenA)){
            //Swap token A for B
            tokenA.transferFrom(msg.sender, address(this), _amountIn);
            uint amountB =  tokenB.balanceOf(address(this)).mul(1e18).div(tokenA.balanceOf(address(this))).mul(_amountIn).div(1e18);
            tokenB.transfer(msg.sender, amountB);
        } 
        else {
            //Swap token B for A
            tokenB.transferFrom(msg.sender, address(this), _amountIn);
            uint amountA =  tokenA.balanceOf(address(this)).mul(1e18).div(tokenB.balanceOf(address(this))).mul(_amountIn).div(1e18);
            tokenA.transfer(msg.sender, amountA);
        }
    }

    function addLiquidity() public{

    }

    function removeLiquidity() public{

    }
}