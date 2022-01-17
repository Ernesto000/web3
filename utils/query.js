const Web3 = require('web3');
const web3 = new Web3(
    '//infura url'
);

console.log(web3);

web3.eth.getBlockNumber().then(number =>{
    console.log(number);
})