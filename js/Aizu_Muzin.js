//Info of Aizumujin balance and token contract address
let tokenAddress = "0x4841E1206065221d89935Ae2983EB7682D95D270";
//[ISSUE]faucetのアドレスに変更する必要あり。2023/03/28米田
let walletAddress = "0xCC106Fd59Ce735E3f510fbA9b1C369752f25bBD4";

window.onload = function() {
    if (typeof web3 !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
    } else {
        web3 = new Web3(new Web3.providers.HttpProvider("https://mainnet.infura.io"));
    }
    
    //initializing
    //display the balance of AizuMujin
    getERC20TokenBalance(walletAddress,"result");
    //the balance of the user now access here
}
//get the token balance of AizuMujin
//elm means which element you want to display on
function getERC20TokenBalance(_walletAddress,elm) {
    let balance;
    // ERC20 トークンの残高を取得するための最小限のABI
    let minABI = [
        // balanceOf
        {
        "constant":true,
        "inputs":[{"name":"_owner","type":"address"}],
        "name":"balanceOf",
        "outputs":[{"name":"balance","type":"uint256"}],
        "type":"function"
        },
        // decimals
        {
        "constant":true,
        "inputs":[],
        "name":"decimals",
        "outputs":[{"name":"","type":"uint8"}],
        "type":"function"
        }
    ];

        //  ABI とコントラクト（ERC20トークン）のアドレスから、コントラクトのインスタンスを取得 
        let contract = web3.eth.contract(minABI).at(tokenAddress);
        // 引数にウォレットのアドレスを渡して、balanceOf 関数を呼ぶ
        contract.balanceOf(_walletAddress, (error, balance) => {
        // ERC20トークンの decimals を取得
        contract.decimals((error, decimals) => {
        // 残高を計算
        balance = balance.div(10**decimals);
        console.log(balance.toString());
        //display balance of Aizumujin
        document.getElementById(elm).innerText = balance.toString();
        });
    });
}

function getERC20TokenContract(tokenAddress) {
    let minABI = [
        {"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"type":"function"},
        {"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"type":"function"},
        {"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"type":"function"}
    ];
    return web3.eth.contract(minABI).at(tokenAddress);
}

function onAddressChange(e) { 
    let tokenAddress = document.getElementById('myAddress').value; 
    if(tokenAddress != "") 
    { 
        getERC20TokenBalance(tokenAddress, "result2");
    }
} 