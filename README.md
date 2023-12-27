- Peer-to-peer network (P2P) => a group of computers each of which acts as node for sharing a file/data within the group, instead of having a centralize server
- EIP => Ethereum Improvement Proposal
- Immutable smart contract => means once contract has been deployed it cant be change anymore
- blockhash - start with 4 zero

- in blockchain peer-to-peer means node-to-node or computer-to-computer, each node/computer that run this blockchain network have the same data. if one of the computer/node data invalid from other node, that one node get kick out from the network.

-mining -> is a process of finding a solution for a blockchain problem.
- hash => a unique length that represents of data;
- nonce => a number that used once to find a solution to the blockchain problem, also 
  define as tx number for an account/address

- consensus mechanism
 - proof of work => sybil resistance mechanism ( defence againts user creating a fake node to gain more rewards )
 - proof of stake => chain selection

 => in proof of work every node competing each other to find a correct nonce and get rewards
 => in proof of stake only one node selected randomly to propose a new block and other nodes become a validator to validate the new block 
  - good with sybil resistance mechanism ( coz every node should stake 32 ETH to join network )
  - use less electricity
  - low gas fees

  == poW & poS both uses a sybil resistance mechanism
  == the bigger blockchain the more secure it becomes
  == layer 1 is a base implementation of the blokchain like ( ETH, BITCOIN )

  ## Smart contract development
  - basic types => ( bytes, string, boolean, mapping, struct, array, enum )
  - advanced topic:
    -  modifier function, 
    - constructor, => only run once
    - receive & fallback func
    - custom error 
    - send ether ( transfer, send, call ) 
    - library => cannot define any state var
    - interface => cannot have a function implementation

  ## Deployment
  - forge create --rpc-url rpc-url --private-key pk contract
  <!-- deploy with this --interactive not showing our private key  -->
  - forge create contractName --interactive
  <!-- or clear history with history -c -->

  <!-- deploy contract via script -->
  <!-- command -->
  forge script script/TokenA.s.sol:TokenADeploy --rpc-url $GOERLI_RPC_URL --broadcast --verify -vvvv

  <!-- to load .env file -->
  source .env

  <!-- FOUNDRY TOOLS -->
  - forge => for interacting with contract
  - cast => interacting with deployed contract
  - anvil => local network

  <!-- testing -->
  forge test
  forge test -vv ( -vv means for visibility of info )
  forge test -m testFunc ( for only test specific func )

  <!-- test step -->
  - unit test => testing a unit (single) of function
  - integration test => testing multiple function combine in single test
  - staging test => testing in a real environtment ( testnet, mainnet )

  <!-- mock contract -->
  - mock contract means - deploy live contract on our local so that we can test that live contract on our local


  ## Resource for Opcode to work with assembly
  [https://www.evm.codes/](evm-codes)

  ### Gas Optimazations
  - storage => cost 100 gas (read/write)
  - memory => cost 3 gas (read/write)
  - immutable and constant variable is not store in storage ( its part of contract bytecode )

  ## Solidity contract layout
  // Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions