// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Vesting} from "./Vesting.sol";
import {Math} from "./libs/Math.sol";

error Renounce_Failed(string reason);

contract TokenA is ERC20 {
    using Math for uint256;

    mapping(string => address) public customAddr;

    uint256 public number;
    address private s_owner;
    bytes32 private CLAIMER_ROLE = keccak256("CLAIMER_ROLE");
    bytes32 private OWNER_ROLE = keccak256("OWNER_ROLE");
    string[2][3] private funders = [["mohammed", "izdihaar"], ["", ""]];

    event Renounced(address indexed sender, string reason);

    constructor() ERC20("MyToken", "MT") {
        s_owner = msg.sender;
        _mint(msg.sender, 1000_000 * 1e18);
    }

    modifier OnlyOwner() {
        require(msg.sender == s_owner, "not owner");
        _;
    }

    /**
     * @dev -renounce_owner
     *  @param newOwner => address type
     *  @param mssg => just a msg
     */
    function renounceOwner_(address newOwner, string calldata mssg) public OnlyOwner {
        bytes32 hashEncoded = keccak256(abi.encode(mssg));

        if (newOwner != address(0)) {
            s_owner = newOwner;
            emit Renounced(msg.sender, "Renounced");
        } else {
            revert Renounce_Failed("failed");
        }
    }

    function transfer(address to_, uint256 value) public override returns (bool) {
        require(msg.sender != address(0), "zero address");

        _transfer(msg.sender, to_, value);
        return true;
    }

    function getOwner() public returns (address) {
        return s_owner;
    }

    function isAddressInlcuded(uint256 amount) public view returns (bool) {
        if (msg.sender != s_owner) {
            return false;
        }

        return true;
    }

    function burning(uint256 amount) public {
        number.Add(amount);
    }

    function registryCustomAddr(uint160 dotEth, string memory customAddrName) public returns (address newAddr) {
        customAddr[customAddrName] = address(dotEth);
    }
}
