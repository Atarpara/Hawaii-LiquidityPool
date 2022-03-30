<div align="center">
   <h1 align="center">Hawaii Liquidity Pools</h3>
   <h4 align="center">Studing Defi and Erc standards</h4> 
</div>
<br>
<div align="center">
   
   ![output-onlinepngtools](https://user-images.githubusercontent.com/38867931/160844411-3f11d20d-1a23-4de4-ac1b-8277e9dcf70a.png)

</div>
<br>



## About the Project 

This project is born to give me (and anyone who wants to contribute to the project) the possibility to learn Solidity (Defi, Ercs standards ...) and Hardhat, anyone can contribute adding a Defi, NFT functionality or improve one that already exists. You can create new tokens, or use existing ones to create new contracts and functions(tested with hardhat is better).

Convered Concepts until now :
- erc20
- primitive swap
- buy erc20 tokens with eth 
- liquidity pool (wip)


**Any idea or contrinute is appreciated!**


## Built With
* [Solidity](https://docs.soliditylang.org/en/v0.8.13/) 
* [Hardhat](https://hardhat.org/) 

## Functionalities

### Honululu and Volcano (ERC20)Token


```solidity

contract LuluToken is ERC20 {
    constructor() ERC20("Honululu", "LULU") {
        _mint(msg.sender, 100 ether);
    }
}


contract VolcanoToken is ERC20 {
    constructor() ERC20("Volcano", "VOLC") {
        _mint(msg.sender, 100 ether);
    }
}

  ```
---


## Getting Started with Hardhat 

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat node
npx hardhat test
npx hardhat help
```

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**. 

1. If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again! ❤️

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

[Conventional Commits name](https://www.conventionalcommits.org/en/v1.0.0/)

* **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
* **ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
* **docs**: Documentation only changes
* **feat**: A new feature
* **fix**: A bug fix
* **perf**: A code change that improves performance
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
* **test**: Adding missing tests or correcting existing tests

[Solidity Style Guide](https://docs.soliditylang.org/en/v0.8.11/style-guide.html)


## Team

Matteo Leonesi - [Github](https://github.com/MatteoLeonesi) - matteo.leonesi@gmail.com


