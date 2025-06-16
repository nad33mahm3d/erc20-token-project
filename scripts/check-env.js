require('dotenv').config();

console.log('Checking environment variables...');
console.log('PRIVATE_KEY length:', process.env.PRIVATE_KEY ? process.env.PRIVATE_KEY.length : 'not set');
console.log('TESTNET_RPC_URL:', process.env.TESTNET_RPC_URL ? 'set' : 'not set');
console.log('POLYGON_RPC_URL:', process.env.POLYGON_RPC_URL ? 'set' : 'not set');
console.log('POLYGONSCAN_API_KEY:', process.env.POLYGONSCAN_API_KEY ? 'set' : 'not set'); 