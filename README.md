# NAD Token

An ERC20 token with staking functionality, deployable on testnet and Polygon chain.

## Features

- Total supply capped at 1 million tokens
- Initial supply of 10,000 tokens
- Staking functionality with rewards
- Token burning capability
- Pausable functionality for emergencies
- Access control for admin functions
- Bonus rewards for large stakers

## Staking Features

- 5% base annual reward rate
- Additional 2% bonus for staking 1000+ tokens
- 30-day minimum staking period
- Automatic reward calculation
- View pending rewards

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file with the following variables:
```
PRIVATE_KEY=your_wallet_private_key
TESTNET_RPC_URL=your_testnet_rpc_url
POLYGON_RPC_URL=your_polygon_rpc_url
POLYGONSCAN_API_KEY=your_polygonscan_api_key
```

## Deployment

To deploy to testnet:
```bash
npm run deploy:testnet
```

To deploy to Polygon mainnet:
```bash
npm run deploy:polygon
```

## Contract Functions

### User Functions
- `stake(uint256 amount)`: Stake your tokens
- `unstake()`: Unstake your tokens and claim rewards
- `getStakeInfo(address staker)`: View stake details and pending rewards

### Admin Functions
- `mint(address to, uint256 amount)`: Mint new tokens (up to max supply)
- `pause()`: Pause all token transfers
- `unpause()`: Unpause token transfers
- `burn(uint256 amount)`: Burn tokens

## Security

- Contract is pausable for emergency situations
- Only owner can mint new tokens
- Staking rewards are capped by max supply
- All functions are protected against reentrancy attacks 