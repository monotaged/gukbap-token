pragma solidity ^0.5.6;

import "./klaytn-contracts/ownership/Ownable.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/GukBapInterface.sol";

contract FirstcomeAirdrop is Ownable {
    using SafeMath for uint256;

    GukBapInterface public guk;
    uint256 public season = 0;
    uint256 public airdropAmount = 1000 * 1e8;
    mapping(uint256 => mapping(address => bool)) public dropped;

    constructor(GukBapInterface _guk) public {
        guk = _guk;
    }

    function setAirdropAmount(uint256 amount) external onlyOwner {
        airdropAmount = amount;
    }

    function newSeason() external onlyOwner {
        season = season.add(1);
    }

    function airdrop() external {
        require(dropped[season][msg.sender] != true);
        guk.transfer(msg.sender, airdropAmount);
        dropped[season][msg.sender] = true;
    }
}
