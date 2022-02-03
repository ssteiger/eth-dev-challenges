pragma solidity ^0.6.0;

contract TheDAO {
    event TokensBought(address recipient, uint amount);
    event TokensTransfered(address from, address to, uint amount);
    event InsufficientFunds(address account, uint balance);
    event Withdraw(address recipient, uint amount);

    mapping (address => uint) private balances;

    constructor () public payable {}

    function buyTokens() public payable {
        balances[msg.sender] += msg.value;
        emit TokensBought(msg.sender, msg.value);
    }

    function balanceOf(address _account) public view returns (uint balance) {
        return balances[_account];
    }

    function transferTokens(address _to, uint _amount) public returns (bool) {
        if (balances[msg.sender] < _amount)
            return false;

        balances[_to] = _amount;
        balances[msg.sender] -= _amount;
        emit TokensTransfered(msg.sender, _to, _amount);
        return true;
    }

    function withdraw(address _recipient) public returns (bool) {
        if (balances[msg.sender] == 0) {
            emit InsufficientFunds(msg.sender, balances[msg.sender]);
            return false;
        }
        emit Withdraw(_recipient, balances[msg.sender]);
        (bool result,) = _recipient.call.value(balances[msg.sender])("");
        //(bool result,) = msg.sender.call{value: balances[msg.sender]}("");
        if (result) {
            balances[msg.sender] = 0;
            return true;
        }
    }
}
