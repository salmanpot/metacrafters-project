// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract CrowdFunding {

    address public token;
    address public owner;
    uint public funding;
    uint public fundingGoal;
    
    bool private initialized;
    mapping (address => uint) private deposits;

    modifier onlyOwner() {
        require(owner == msg.sender, "caller is not the owner");
        _;
    }

    event Pledge(address indexed from, uint amount);
    event Claim(address indexed to, uint amount);
    event Withdraw(address indexed token, address indexed to, uint amount);

    // Uncomment to deploy as a simple contract
    // constructor(address owner_, address token_, uint fundingGoal_) {
    //     initialize(owner_, token_, fundingGoal_);
    // }
    
    function initialize(address owner_, address token_, uint fundingGoal_) public {
        require(!initialized, "already initialized");
        require(owner_ != address(0), "owner address is zero");
        require(token_ != address(0), "token address is zero");
        require(fundingGoal_ > 0, "fundingGoal is zero");
        token = token_;
        owner = owner_;
        fundingGoal = fundingGoal_;
        initialized = true;
    }

    // Uncomment if you want to update fundingGoal in future
    // function setFundingGoal(uint fundingGoal_) external onlyOwner {
    //     require(fundingGoal_ > 0, "fundingGoal is zero");
    //     fundingGoal = fundingGoal_;       
    // }

    function pledge(uint amount) external {
        require(amount > 0, "amount is zero");
        require(funding < fundingGoal, "funding goal reached"); //Remove if you want to pledge funds even after funding goal reached
        deposits[msg.sender] += amount;
        funding += amount;
        emit Pledge(msg.sender, amount);
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "insufficient funds balance/approval");
    }

    function claim(uint amount) external {
        require(amount > 0 && amount <= deposits[msg.sender], "invalid claim amount");
        require(funding < fundingGoal, "funding goal reached");
        deposits[msg.sender] -= amount;
        funding -= amount;
        emit Claim(msg.sender, amount);
        require(IERC20(token).transfer(msg.sender, amount), "insufficient funds");
    }

    function getDeposit(address user) external view returns (uint) {
        return deposits[user];
    }

    function withdrawToken(address tk, address to, uint256 amount) external onlyOwner {
        if (tk == token)
            require(funding >= fundingGoal);
        emit Withdraw(tk, to, amount);
        require(IERC20(tk).transfer(to, amount), "withdraw token failed");
    }
}