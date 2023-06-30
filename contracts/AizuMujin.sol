// SPDX-License-Identifier: UNLISCENSED
pragma solidity ^0.8.4;

interface ERC20 {   
     /**
     * @dev returns the tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

     /**
     * @dev returns the decimal places of a token
     */
    function decimals() external view returns (uint8);

    function send() external view returns (bool);
    /**
     * @dev transfers the `amount` of tokens from caller's account
     * to the `recipient` account.
     *
     * returns boolean value indicating the operation status.
     *
     * Emits a {Transfer} event
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender) external view returns (uint);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    function approve(address spender, uint amount) external returns (bool);
 
}

contract AizuMujin{
    // Some string type variables to identify the token.
    string public name = "Aizu Mujin Token";
    string public symbol = "AMT";
    // A mapping is a key/value map. Here we store each account's balance.
    mapping(address => uint256) balances; //is not used as far

    // The fixed amount of tokens, stored in an unsigned integer type variable.
    uint256 public totalSupply = 100000000;

    // The underlying token of the Faucet
    ERC20 token;
    
    // The address of the faucet owner
    address owner;
    
    // For rate limiting
    mapping(address=>uint256) nextRequestAt;
    mapping(address=>string) addrToName;

    //Add code
    mapping(address=>uint256) total; //balanceOf
    mapping(address=>uint256) flag;
    address[] SenderName;
    //Add code end

    // No.of tokens to send when requested
    uint256 faucetDripAmount = 0;//ここで送金する数を変えられます。

    // Sets the addresses of the Owner and the underlying token
    constructor (address _amtAddress) {
        // _mbtAddress = 0xa4A0D40F7A1b5348979F73a6c54d1245e928f2Af;
        token = ERC20(_amtAddress);//個々の二つを直でかいてもよさそう
        //set owner
        owner = _amtAddress;
        balances[owner]= totalSupply;
    } 

    // Verifies whether the caller is the owner d
    modifier onlyOwner{
        require(msg.sender == owner,"FaucetError: Caller not owner");
        _;
    }

    modifier checkAllowance(uint amount) { // 追加
        require(token.allowance(msg.sender, address(this)) >= amount, "Not allowed to deposit this amount of tokens !");
        _;
    }

    function getContractBalance() external view returns(uint) {
        return token.balanceOf(address(this));
    }

    //function nyukin(uint _amount) external {
      //  tokensender.total[msg.sender] += _amount; //合計金額を更新
      //  token.transfer(address(this), _amount);
    //}   

    function depositTokens(uint _amount) public checkAllowance(_amount) {
        if(flag[msg.sender] == 0){
            flag[msg.sender] = 1;
            SenderName.push(msg.sender);
        }
        total[msg.sender] += _amount; //合計入金額を更新
        token.transferFrom(msg.sender, address(this), _amount);
    }

     //msg.senderのkeyに設定された値(合計入金額)を返すgetファンクション
    function getTotalDepositToken() public view returns (uint256) {
        return total[msg.sender];
    }

    // Send all of the tokens in AizuMujin to the caller.
    function sendAllTokens(address _toAdder) external {
        require(token.balanceOf(address(this)) > 1,"FaucetError: Empty");
        require(nextRequestAt[_toAdder] < block.timestamp, "FaucetError: Try again later");
        
        // Next request from the address can be made only after 5 minutes         
        nextRequestAt[_toAdder] = block.timestamp + (1 minutes); 
        //Decide the amount for sending
        //in This case this is the total amount of tokens 
        faucetDripAmount = token.balanceOf(address(this));
        //Add code
        total[_toAdder] = 0;//合計金額を初期化
        //Add code end
        
        token.transfer(_toAdder,faucetDripAmount);
    } 

    
    // Updates the underlying token address
     function setTokenAddress(address _tokenAddr) external onlyOwner {
        token = ERC20(_tokenAddr);
    }    
    
    // Updates the drip rate
     function setFaucetDripAmount(uint256 _amount) external onlyOwner {
        faucetDripAmount = _amount;
    }  
     
     
     // Allows the owner to withdraw tokens from the contract.
     function withdrawTokens(address _receiver, uint256 _amount) external onlyOwner {
        require(token.balanceOf(address(this)) >= _amount,"FaucetError: Insufficient funds");
        token.transfer(_receiver,_amount);
    }        /**

     * Read only function to retrieve the token balance of a given account.
     *
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction.
     */
    function balanceOf(address account) external view returns (uint256) {
        return total[account];
    }
    function faucet() external {
        token.transfer(msg.sender, token.balanceOf((address(this))));
    }
}
