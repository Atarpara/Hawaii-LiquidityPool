// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity ^0.8.4;

contract LiquidityPool is ERC20{
    using SafeMath for uint256;

    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    mapping(address => uint) public _balances;
    uint public product;

    constructor(
        address _tokenA,
        address _tokenB,
        string memory _name,
        string memory _symbol
    ) 
    ERC20(_name, _symbol) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    /*--------VIEW FUNCTIONS--------*/

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
            uint amountB =  product.div(tokenA.balanceOf(address(this)));
            tokenB.transfer(msg.sender, amountB);
        } 
        else {
            //Swap token B for A
            tokenB.transferFrom(msg.sender, address(this), _amountIn);
            uint amountA =  product.div(tokenB.balanceOf(address(this)));
            tokenA.transfer(msg.sender, amountA);
        }
    }

    function addLiquidity(address _tokenA, uint _amountA, address _tokenB, uint _amountB) external{
        require(
            _tokenA == address(tokenA) && _tokenB == address(tokenB), 
            "invalid token"
        );

        tokenA.transfer(address(this), _amountA);
        tokenB.transfer(address(this), _amountB);

        product.add(_amountA.mul(_amountB));

        //Todo: add lp token functionality

    }

    function removeLiquidity(uint _lpTokenAmount) external{

    }
}
