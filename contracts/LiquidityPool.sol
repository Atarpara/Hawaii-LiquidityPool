// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity ^0.8.4;

contract LiquidityPool is ERC20{
    using SafeMath for uint256;
    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    mapping(address => uint256) public _balances;
    uint256 public product;
    uint256 private MINIMUM_LIQUIDITY = 10**3;
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
    function getPriceRatio() public view returns (uint256){
        return tokenB.balanceOf(address(this)).mul(1e18).div(tokenA.balanceOf(address(this)));
    }
    /*--------Square Root Function--------*/
    /* Returns the Sqaure root Of Y
    returns sqrt(9) = 3   */
    function sqrt(uint256 y) internal pure returns (uint256 z) {
    if (y > 3) {
        z = y;
        uint x = y / 2 + 1;
        while (x < z) {
            z = x;
            x = (y / x + x) / 2;
        }
    } else if (y != 0) {
        z = 1;
    }
}
     /*----------GET MINIMUM VALUE-----------*/
    function min(uint256 x, uint256 y) internal pure returns(uint256){
        if(x => y)
        return y;
        else
        return x;
    }
    /*--------MUTATIVE FUNCTIONS--------*/

    function swap(address _tokenIn, uint256 _amountIn) external{
        require(
            _tokenIn == address(tokenA) || _tokenIn == address(tokenB),
            "invalid token"
        );

        if (_tokenIn == address(tokenA)){
            //Swap token A for B
            tokenA.transferFrom(msg.sender, address(this), _amountIn);
            uint256 amountB =  product.div(tokenA.balanceOf(address(this)));
            tokenB.transfer(msg.sender, amountB);
        } 
        else {
            //Swap token B for A
            tokenB.transferFrom(msg.sender, address(this), _amountIn);
            uint256 amountA =  product.div(tokenB.balanceOf(address(this)));
            tokenA.transfer(msg.sender, amountA);
        }
    }

    function addLiquidity(address _tokenA, uint256 _amountA, address _tokenB, uint256 _amountB) external{
        require(
            _tokenA == address(tokenA) && _tokenB == address(tokenB), 
            "invalid token"
        );
        require(
            _amountA > 0 && _amountB > 0, "Liquidity Amounts Must be greater then Zero"
        );  

        uint256 lpTokenAmount;

        //Check token ratio correct
        if (product != 0){
            require(
                _amountA.mul(1e18).div(_amountB) == tokenA.balanceOf(address(this)).mul(1e18).div(tokenB.balanceOf(address(this)))
            ,"Invalid the Liquidity Ratio.");
        }

        tokenA.transfer(address(this), _amountA);
        tokenB.transfer(address(this), _amountB);
        
        // product (x+dx) * (y+dy) = constant 
        
        // Logic Adopted from uniswap V2
        uint256 _totalSupply = totalSupply();
        if(_totalSupply == 0) 
           lpTokenAmount = sqrt(_amountA.mul(_amountB).sub(MINIMUM_LIQUIDITY));
           _mint(address(0), MINIMUM_LIQUIDITY);
        else
            lpTokenAmount = min(_amountA.mul(_totalSupply),_amountB.mul(_totalSupply));

        product = tokenA.balanceOf(address(this)).mul(tokenB.balanceOf(address(this)));    
        _mint(msg.sender, lpTokenAmount);
    }

    function removeLiquidity(uint256 _lpTokenAmount) external{
        _burn(msg.sender, _lpTokenAmount);
        //Calculate amount of tokens to send to user
        uint256 userShare = _lpTokenAmount.mul(1e18).div(totalSupply());
        uint256 amountA = userShare.mul(tokenA.balanceOf(address(this))).div(1e18);
        uint256 amountB = userShare.mul(tokenB.balanceOf(address(this))).div(1e18);

        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);
    }
}
