// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract NADToken is ERC20, Pausable, Ownable, ERC20Burnable {
    // Staking related variables
    struct Stake {
        uint256 amount;
        uint256 timestamp;
        uint256 rewardRate;
    }

    mapping(address => Stake) public stakes;
    uint256 public constant REWARD_RATE = 5; // 5% annual reward rate
    uint256 public constant STAKE_DURATION = 30 days;
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10**18; // 1 million tokens
    uint256 public constant INITIAL_SUPPLY = 10_00 * 10**18; // 1000 tokens

    event Staked(address indexed user, uint256 amount, uint256 timestamp);
    event Unstaked(address indexed user, uint256 amount, uint256 reward);
    event TokensBurned(address indexed burner, uint256 amount);

    constructor() ERC20("NAD Token", "NAD") Ownable(msg.sender) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner whenNotPaused {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds max supply");
        _mint(to, amount);
    }

    function stake(uint256 amount) public whenNotPaused {
        require(amount > 0, "Cannot stake 0 tokens");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        // Transfer tokens to contract
        _transfer(msg.sender, address(this), amount);

        // Calculate reward rate based on stake amount
        uint256 rewardRate = REWARD_RATE;
        if (amount >= 1000 * 10**18) {
            rewardRate = REWARD_RATE + 2; // Additional 2% for large stakers
        }

        // Create or update stake
        stakes[msg.sender] = Stake({
            amount: amount,
            timestamp: block.timestamp,
            rewardRate: rewardRate
        });

        emit Staked(msg.sender, amount, block.timestamp);
    }

    function unstake() public whenNotPaused {
        Stake storage userStake = stakes[msg.sender];
        require(userStake.amount > 0, "No stake found");
        require(block.timestamp >= userStake.timestamp + STAKE_DURATION, "Stake not matured");

        uint256 stakedAmount = userStake.amount;
        uint256 reward = calculateReward(msg.sender);

        // Clear the stake
        delete stakes[msg.sender];

        // Transfer staked amount and reward
        _transfer(address(this), msg.sender, stakedAmount);
        if (reward > 0) {
            require(totalSupply() + reward <= MAX_SUPPLY, "Reward would exceed max supply");
            _mint(msg.sender, reward);
        }

        emit Unstaked(msg.sender, stakedAmount, reward);
    }

    function calculateReward(address staker) public view returns (uint256) {
        Stake storage userStake = stakes[staker];
        if (userStake.amount == 0) return 0;

        uint256 stakingDuration = block.timestamp - userStake.timestamp;
        if (stakingDuration < STAKE_DURATION) return 0;

        // Calculate reward based on annual rate
        return (userStake.amount * userStake.rewardRate * stakingDuration) / (365 days * 100);
    }

    function getStakeInfo(address staker) public view returns (uint256 amount, uint256 timestamp, uint256 rewardRate, uint256 pendingReward) {
        Stake storage userStake = stakes[staker];
        return (
            userStake.amount,
            userStake.timestamp,
            userStake.rewardRate,
            calculateReward(staker)
        );
    }

    function burn(uint256 amount) public override whenNotPaused {
        super.burn(amount);
    }

    function burnFrom(address account, uint256 amount) public override whenNotPaused {
        super.burnFrom(account, amount);
    }
} 