# MetaCrafters Crowd Funding Project

Crowdfunding campaign where users can pledge funds to and claim funds from the contract

1. Funds take the form of a custom ERC20 token
2. It has a funding goal
3. When a funding goal is not met, customers are be able to get a refund of their pledged funds
4. dApps using the contract can observe state changes in transaction logs
5. Contract is upgradeable

```shell
npx hardhat compile
npx hardhat node
npx hardhat run scripts/deployAsProxy.js
```