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

contract MBTFaucet {
    
    // The underlying token of the Faucet
    ERC20 token;
    
    // The address of the faucet owner
    address owner;
    
    // For rate limiting
    mapping(address=>uint256) nextRequestAt;
    mapping(address=>string) addrToName;

    // No.of tokens to send when requested
    uint256 faucetDripAmount = 0;//ここで送金する数を変えられます。

    // Sets the addresses of the Owner and the underlying token
    constructor (address _mbtAddress) {
        // _mbtAddress = 0xa4A0D40F7A1b5348979F73a6c54d1245e928f2Af;
        token = ERC20(_mbtAddress);//個々の二つを直でかいてもよさそう
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

    // function nyukin(uint _amount) external {

    //     token.transfer(address(this), _amount);
    // }   



    function depositTokens(uint _amount) public checkAllowance(_amount) {
        token.transferFrom(msg.sender, address(this), _amount);
    }

    // Sends the amount of token to the caller.
    function send() external {
        require(token.balanceOf(address(this)) > 1,"FaucetError: Empty");
        require(nextRequestAt[msg.sender] < block.timestamp, "FaucetError: Try again later");
        
        // Next request from the address can be made only after 5 minutes         
        nextRequestAt[msg.sender] = block.timestamp + (1 minutes); 

        faucetDripAmount = 222;//失敗したら222だけ出金

        faucetDripAmount = token.balanceOf(address(this));//追加した部分
        
        token.transfer(msg.sender,faucetDripAmount);
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
    }    

    
}
