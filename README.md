# NAD Token

An ERC20 token with staking functionality, deployable on testnet and Polygon chain.

## Features

- Total supply capped at 1 million tokens
- Initial supply of 1000 tokens
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

## OpenZeppelin Usage

This project uses [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/) for secure, community-vetted smart contract building blocks:

- **ERC20**: Standard token implementation for fungible tokens.
- **ERC20Burnable**: Allows token holders to destroy (burn) their tokens, reducing total supply.
- **Ownable**: Provides access control, restricting certain functions to the contract owner (e.g., minting, pausing).
- **Pausable**: Enables the contract owner to pause and unpause token transfers and sensitive operations in case of emergency.

OpenZeppelin contracts are imported in `contracts/NADToken.sol` and provide a secure foundation for custom logic like staking and rewards.

## Environment Variables Setup

To deploy and interact with the contract, you need to set up a `.env` file in your project root with the following variables:

```
PRIVATE_KEY=your_wallet_private_key
TESTNET_RPC_URL=your_testnet_rpc_url
POLYGON_RPC_URL=your_polygon_rpc_url
POLYGONSCAN_API_KEY=your_polygonscan_api_key
```

### How to Obtain Each Variable

#### 1. `PRIVATE_KEY`
- This is your wallet's private key (never share it with anyone!).
- **MetaMask:**
  1. Open MetaMask and select your account.
  2. Click the three dots > "Account details" > "Export Private Key".
  3. Enter your password and copy the private key (should start with `0x`).
- **Security:** Never commit your `.env` file to version control.

#### 2. `TESTNET_RPC_URL`
- This is the RPC endpoint for the Polygon testnet (e.g., Amoy).
- You can get a free endpoint from:
  - [Alchemy](https://alchemy.com/)
  - [Infura](https://infura.io/)
  - [QuickNode](https://www.quicknode.com/)
- Or use the public Amoy endpoint:
  - `https://rpc-amoy.polygon.technology/`

#### 3. `POLYGON_RPC_URL`
- This is the RPC endpoint for the Polygon mainnet.
- You can get it from Alchemy, Infura, QuickNode, or use the public endpoint:
  - `https://polygon-rpc.com`

#### 4. `POLYGONSCAN_API_KEY`
- This is your API key for contract verification on Polygonscan.
- Get it from [Polygonscan API Keys](https://polygonscan.com/myapikey) (sign up and create a new key).

---

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file with the variables above.

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