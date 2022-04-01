// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "./LiquidityPool.sol";

/// @title A factory contract to create new pools
/// @author @yuripaoloni
contract PoolsFactory {
    //mapping storing all the pools [tokenA][tokenB] => pool address
    mapping(address => mapping(address => address)) public getPool;

    address[] public allPools;

    event PoolCreated(
        address indexed tokenA,
        address indexed tokenB,
        address pool,
        uint256 poolsLenght
    );

    function allPoolsLength() external view returns (uint256) {
        return allPools.length;
    }

    // creates a new pool. Returns the LiquidityPool contract address
    function createPool(
        address tokenA,
        address tokenB,
        string memory name,
        string memory symbol
    ) external returns (address) {
        require(tokenA != tokenB, "Identical address");
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "zero address");
        require(getPool[token0][token1] == address(0), "Pool already exists");

        address pool = address(new LiquidityPool(token0, token1, name, symbol));

        getPool[token0][token1] = pool;
        getPool[token1][token0] = pool; // populate mapping in the reverse direction
        allPools.push(pool);

        emit PoolCreated(token0, token1, pool, allPools.length);

        return pool;
    }
}
