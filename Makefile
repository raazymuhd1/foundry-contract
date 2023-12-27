include .env

forge build:; forge build

deploy-goerli:
	forge script script/FundMe.s.sol:DeployFund --rpc-url $(GOERLI_RPC_URL) --private-key $(PRIVATE_KEY) --etherscan-api-key $(ETHERSCAN_API_KEY) --verify --broadcast -vvvv

verify-existing:
	forge verify-contract \
    --chain-id 5 \
    --num-of-optimizations 1000000 \
    --watch \
    --etherscan-api-key $(ETHERSCAN_API_KEY) \
    --compiler-version v0.8.20+commit.fc410830 \
    0xb4cea5C7151e370ef2eBC81f6C76DFf7F08335E2 \
    src/FundMe.sol:FundMe 