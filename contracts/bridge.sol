// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
import "./interface/IERC20.sol";
/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


interface bridgeNFT {
     function owner() external view  returns (address);
     function mint(address to , uint256 tokenId) external;
      function burn(uint256 tokenId) external;
}

interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}


/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */

 
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, _msgSender(), currentAllowance - amount);
        }

        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}
interface IERCOwnable {
     function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
    
     function owner() external view  returns (address);
    }





interface IRegistery {
    struct Transaction{
            uint256 chainId;
            address assetAddress;
            uint256 id;
            address receiver;
            uint256 nounce;
            bool  isCompleted;
        }

    function getUserNonce(address user) external returns (uint256);
    function isSendTransaction(bytes32 transactionID) external returns (bool);
    function isClaimTransaction(bytes32 transactionID) external returns (bool);
    function isMintTransaction(bytes32 transactionID) external returns (bool);
    function isburnTransactio(bytes32 transactionID) external returns (bool);
    function transactionValidated(bytes32 transactionID) external returns (bool);
    function assetChainBalance(address asset, uint256 chainid) external returns (uint256);

    function sendTransactions(bytes32 transactionID) external returns (Transaction memory);
    function claimTransactions(bytes32 transactionID) external returns (Transaction memory);
    function burnTransactions(bytes32 transactionID) external returns (Transaction memory);
    function mintTransactions(bytes32 transactionID) external returns (Transaction memory);
    
    function completeSendTransaction(bytes32 transactionID) external;
    function completeBurnTransaction(bytes32 transactionID) external;
    function completeMintTransaction(bytes32 transactionID) external;
    function completeClaimTransaction(bytes32 transactionID) external;
    function transferOwnership(address newOwner) external;
    
  
    
      function registerTransaction(
       uint256 chainTo,
       address assetAddress,
       uint256 amount,
       address receiver,
       uint8 _transactionType
        ) 
        external  
        returns (bytes32 transactionID ,uint256 _nounce );
     
}
interface IController {
    function isAdmin(address account) external view returns (bool);
    function isRegistrar(address account) external view returns (bool);
    function isOracle(address account) external view returns (bool);
    function isValidator(address account) external view returns (bool);
    function owner() external view returns (address);
    
}
interface Isettings {

    function networkFee(uint256 chainId) external returns (uint256);
    function minValidations() external returns (uint256);
    function isNetworkSupportedChain(uint256 chainID) external returns (bool);
    function feeRemitance() external view returns (address);
    function railRegistrationFee() external view returns (uint256);
    function railOwnerFeeShare() external view returns (uint256);
    function onlyOwnableRail() external view returns (bool);
    function minWithdrawableFee() external view returns (uint256);
    function brgToken() external view returns (address);
    function getNetworkSupportedChains() external view returns(uint256[] memory);
    function baseFeePercentage() external view returns(uint256);
    function baseFeeEnable() external view returns(bool);
    function approvedToAdd(address token , address user) external view returns(bool);
}


interface IfeeController {
    function getBridgeFee(address sender, address asset, uint256 chainTo ) external view returns(uint256);
}

contract ERC721Holder is IERC721Receiver {
    /**
     * @dev See {IERC721Receiver-onERC721Received}.
     *
     * Always returns `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}

contract Bridge is ERC721Holder , Context , ReentrancyGuard {
    
    struct asset {
        address tokenAddress;
        uint256 feeBalance;
        uint256 collectedFees;
        bool ownedRail;
        address manager;
        address feeRemitance;
        uint256 balance;
        bool isSet;
   }
   

   IController  public controller;
   Isettings public settings;
   IRegistery  public registry;
   bool public paused;
   
   mapping(address => asset) public nativeAssets;
   mapping(address => bool) public isActiveNativeAsset;
   mapping(address => uint256[])  assetSupportedChainIds;
   mapping(address => mapping(uint256 => bool)) public  isAssetSupportedChain;
   mapping(address => uint256 ) public  foriegnAssetChainID;
   mapping(address => asset) public foriegnAssets;
   mapping(address => mapping(uint256 => address)) public wrappedForiegnPair;
   mapping(address => address)  foriegnPair;
   mapping(address => mapping(uint256 => bool))  hasWrappedForiegnPair;
   

   uint256  totalFees;
   uint256  feeBalance;

   uint256 public chainId;
   address  feeController;
  address[] public foriegnAssetsList;
   address[]  public nativeAssetsList;
   
   event ForiegnAssetAdded(address indexed foriegnAddress , uint256 indexed chainID ,address indexed  wrappedAddress);
   event UpdatedAddresses(address indexed settings , address indexed feeController);
   event AssetUpdated(address indexed assetAddress ,address indexed  manager ,address indexed  feeRemitance ,bool native );
   event BridgePauseStatusChanged(bool status);


  
   event SendTransaction(
       bytes32 transactionID, 
       uint256 chainID,
       address indexed assetAddress,
       uint256 assetId,
       address indexed receiver,
       uint256 nounce,
       address indexed  sender
    );
   event BurnTransaction(
       bytes32 transactionID,
       uint256 chainID,
       address indexed assetAddress,
       uint256 assetId,
       address indexed receiver,
       uint256 nounce,
       address indexed  sender
    );
   event RailAdded(
       address indexed assetAddress,
       uint256[] supportedChains,
       address[] foriegnAddresses,
       address  registrar,
       bool ownedRail,address indexed manager,
       address  feeRemitance
    );
   


   constructor (address _controllers , address _settings, address _registry, address _feeController) {
       noneZeroAddress(_controllers);
       noneZeroAddress(_settings);
       noneZeroAddress(_registry);
       noneZeroAddress(_feeController);
       settings = Isettings(_settings);
       controller = IController(_controllers);
       registry = IRegistery(_registry);
       feeController = _feeController;
       uint256 id;
       assembly {
        id := chainid()
    }
    chainId = id;
   }
  


  function pauseBrigde() external {
      isOwner();
      paused = !paused;
       emit BridgePauseStatusChanged(paused);
  }


   function updateAddresses(address _settings , address _feeController) external {
       isOwner();
       noneZeroAddress(_settings) ;
       noneZeroAddress(_feeController);
       emit UpdatedAddresses(_settings , _feeController );
       settings = Isettings(_settings);
       feeController = _feeController;

   }




    function activeNativeAsset(address assetAddress , bool activate) public {
    //    require(nativeAssets[assetAddress].isSet , "I_A");
        require(nativeAssets[assetAddress].isSet &&  (controller.isAdmin(_msgSender())  || controller.isRegistrar(_msgSender()) ||  isAssetManager(assetAddress, true)),"U_A");
    //    emit NativeAssetStatusChanged(assetAddress , activate);
       isActiveNativeAsset[assetAddress] = activate;

   }


   function updateAsset(address assetAddress , address manager ,address _feeRemitance) external {
        notPaused();
        noneZeroAddress(manager);  
        noneZeroAddress(_feeRemitance);
        require((foriegnAssets[assetAddress].isSet || nativeAssets[assetAddress].isSet) , "I_A");
        bool native;
        if(isAssetManager(assetAddress ,true)){
            native = true;
           
        }else if(isAssetManager(assetAddress ,false)){
            native = false;
        }
        else {
            isOwner(); 
            if(foriegnAssets[assetAddress].isSet)
                native = false;
            else if(nativeAssets[assetAddress].isSet)
                native = true;
            else 
                require(false ,"U_A");
        }
        
        if(native){
             nativeAssets[assetAddress].manager = manager;
            nativeAssets[assetAddress].feeRemitance = _feeRemitance;
        }else{
            foriegnAssets[assetAddress].manager = manager;
            foriegnAssets[assetAddress].feeRemitance = _feeRemitance;
        }
        
        emit AssetUpdated(assetAddress , manager , _feeRemitance , native);
   }

   

   function registerRail(
      address assetAddress ,
      uint256[] calldata supportedChains,
      address[] calldata foriegnAddresses,
      address feeAccount, 
      address manager
    ) 
    external  
    {
          notPaused();
          bool ownedRail;
          require( supportedChains.length == foriegnAddresses.length, "AL_E");
          if (controller.isAdmin(msg.sender)) {
              if (manager != address(0)  && feeAccount != address(0)) {
                  ownedRail = true;
              }
          } else {
              ownedRail = true;
              if (settings.onlyOwnableRail()) {
              require( _msgSender() == IERCOwnable(assetAddress).owner() || settings.approvedToAdd(assetAddress , msg.sender), "U_A");
              }
              IERC20 token = IERC20(settings.brgToken());
              require(token.transferFrom(_msgSender() , settings.feeRemitance() , supportedChains.length * settings.railRegistrationFee()), "I_F");
            }
            
             _registerRail(assetAddress, supportedChains, ownedRail , feeAccount, manager );
            emit RailAdded(
            assetAddress,
            supportedChains,
            foriegnAddresses,
            _msgSender(),
            ownedRail,
            manager,
            feeAccount
        );
     
    }

   function _registerRail(
       address assetAddress,
       uint256[] memory supportedChains,
      bool ownedRail, 
      address feeAccount, 
      address manager
   )
    internal
   {
        asset storage newNativeAsset = nativeAssets[assetAddress];
       if (!newNativeAsset.isSet ) {
           newNativeAsset.tokenAddress = assetAddress;
           if (ownedRail) {
               if(feeAccount != address(0) && manager != address(0)) {
                   newNativeAsset.ownedRail = true;
                    newNativeAsset.feeRemitance = feeAccount;
                    newNativeAsset.manager = manager;
               }
               
            }
            newNativeAsset.isSet = true;
            isActiveNativeAsset[assetAddress] = false;
            nativeAssetsList.push(assetAddress);
            
       }
     
       uint256 chainLenght = supportedChains.length;
       for (uint256 index; index <  chainLenght; index++) {
           if (settings.isNetworkSupportedChain(supportedChains[index])) {
               if (!isAssetSupportedChain[assetAddress][supportedChains[index]] ) {
                isAssetSupportedChain[assetAddress][supportedChains[index]] = true;
                assetSupportedChainIds[assetAddress].push(supportedChains[index]);
               }  
           }
          
       }
        
   }


   function addForiegnAsset(
       address foriegnAddress,
       uint256 chainID,
       bool OwnedRail,
       address manager,
       address feeAddress,
       address nativeAddress
    ) 
       external 
    {
       
       require(controller.isAdmin(_msgSender()) || controller.isRegistrar(_msgSender()) ,'U_A_r');
       require(settings.isNetworkSupportedChain(chainID) && !hasWrappedForiegnPair[foriegnAddress][chainID] , "registered");
       require(bridgeNFT(nativeAddress).owner() == address(this) , "bridge not owner");
       address wrappedAddress =  nativeAddress;
       foriegnAssets[wrappedAddress] = asset(wrappedAddress , 0 ,0,OwnedRail , manager,feeAddress  , 0, true);
       foriegnAssetChainID[wrappedAddress] = chainID;
       foriegnPair[wrappedAddress] = foriegnAddress;
       foriegnAssetsList.push(wrappedAddress);
       wrappedForiegnPair[foriegnAddress][chainID] =  wrappedAddress;
       hasWrappedForiegnPair[foriegnAddress][chainID] = true;
       emit ForiegnAssetAdded(foriegnAddress , chainID , wrappedAddress);
   }

 

  
   function send(uint256 chainTo ,  address assetAddress , uint256 id ,  address receiver ) external payable nonReentrant returns (bytes32 transactionID) {
       notPaused();
    //    require(, "C_E");
       require(isActiveNativeAsset[assetAddress] && isAssetSupportedChain[assetAddress][chainTo] , "AL_E");
       noneZeroAddress(receiver);
       
       deductFees(assetAddress , chainTo , true);
       sendNTF(_msgSender(), address(this), assetAddress,id);
        uint256 nounce;
        (transactionID , nounce) = registry.registerTransaction(chainTo , assetAddress , id , receiver  , 0);
      
     
        emit SendTransaction(
            transactionID,
            chainTo,
            assetAddress,
            id,
            receiver,
            nounce,
            msg.sender
        );
   
   }


   function burn( address assetAddress , uint256 id ,  address receiver) external payable  nonReentrant returns (bytes32 transactionID){
       notPaused();
       uint256 chainTo = foriegnAssetChainID[assetAddress];
       require(foriegnAssets[assetAddress].isSet  , "I_A");
       
       noneZeroAddress(receiver);
         bool success =  processedPayment(assetAddress , chainTo, id);
         require(success  , "I_f");
       deductFees(assetAddress , chainTo , false);
       bridgeNFT(assetAddress).burn(id);
       address _foriegnAsset = foriegnPair[assetAddress];
       uint256 nounce;
        (transactionID , nounce)  = registry.registerTransaction( chainTo , _foriegnAsset ,id , receiver , 1);

        emit BurnTransaction(
            transactionID,
            chainTo,
            _foriegnAsset,
            id,
            receiver,
            nounce,
            msg.sender
        );
    }
   
  
   function mint(bytes32 mintID) public  nonReentrant { 
       notPaused();
    //    require(, "MI_E");
       IRegistery.Transaction memory transaction = registry.mintTransactions(mintID);
       require(registry.isMintTransaction(mintID) && !transaction.isCompleted && registry.transactionValidated(mintID), "M");
       bridgeNFT(transaction.assetAddress).mint(transaction.receiver , transaction.id);
       registry.completeMintTransaction(mintID);

   }


   function claim(bytes32 claimID) public  nonReentrant {
       notPaused();
    //    require( , "CI_E");
       IRegistery.Transaction memory transaction = registry.claimTransactions(claimID);
       require(registry.isClaimTransaction(claimID)  && !transaction.isCompleted && registry.transactionValidated(claimID) ,"AL_E");
    //    require(, "C");
    //    require(, "N_V");
       
       sendNTF(address(this) , transaction.receiver, transaction.assetAddress , transaction.id);
       registry.completeClaimTransaction(claimID);
   }


   
function sendNTF(address sender, address recipient ,address _tokenAddress ,uint256 _tokenID ) internal {
        IERC721 NFTtoken =  IERC721(_tokenAddress);
        NFTtoken.safeTransferFrom(sender, recipient , _tokenID);
    }
    
    // internal fxn used to process incoming payments 
    function processedPayment(address assetAddress ,uint256 chainID, uint256 id) internal returns (bool) {
        uint256 fees = IfeeController(feeController).getBridgeFee(msg.sender, assetAddress, chainID);
     
            IERC721 token = IERC721(assetAddress);
            if (token.getApproved(id) == address(this) && (msg.value >=  fees)) {
               
                token.safeTransferFrom(_msgSender(), address(this) , id);
               return (true );
            } else {
                return (false );
            }
        
    }


   // internal fxn for deducting and remitting fees after a sale
    function deductFees(address assetAddress , uint256 chainID , bool native) private {
            uint256 fees_to_deduct = IfeeController(feeController).getBridgeFee(msg.sender, assetAddress, chainID);
            require(msg.value >= fees_to_deduct , "I_F");
            asset storage currentasset;
            if(native)
                currentasset = nativeAssets[assetAddress];
            else
                currentasset = foriegnAssets[assetAddress];
            
            require(currentasset.isSet ,"I_A");

            // uint256 fees_to_deduct = settings.networkFee(chainID);


            totalFees = totalFees + fees_to_deduct;
        
            if (currentasset.ownedRail) {
            uint256 ownershare = fees_to_deduct * settings.railOwnerFeeShare() / 100;
            uint256 networkshare = fees_to_deduct - ownershare;
            currentasset.collectedFees += fees_to_deduct;
            currentasset.feeBalance += ownershare;
            feeBalance = feeBalance + networkshare;

            } else {
                currentasset.collectedFees += fees_to_deduct;
                feeBalance = feeBalance + fees_to_deduct;
            }
            remitFees( assetAddress,  native);
           
     }

    function  remitFees(address assetAddress, bool native) public {
        
         asset storage currentasset;
         uint256 amount;
            if(native)
                currentasset = nativeAssets[assetAddress];
            else
                currentasset = foriegnAssets[assetAddress];
            
         if (feeBalance > settings.minWithdrawableFee()) {

                if (currentasset.ownedRail) {
                    if (currentasset.feeBalance > 0) {
                         amount = currentasset.feeBalance;
                        currentasset.feeBalance = 0;
                        payoutUser(payable(currentasset.feeRemitance), address(0), amount );
                        
                    }
                }
                if (feeBalance > 0) {
                     
                    amount = feeBalance;
                    feeBalance = 0;
                    payoutUser(payable(settings.feeRemitance()), address(0), amount );
                    
                    //recieve excess fees
                    if(address(this).balance > nativeAssets[address(0)].balance ){
                        uint256 excess = address(this).balance - nativeAssets[address(0)].balance;
                        payoutUser(payable(settings.feeRemitance()), address(0), excess );
                    } 
                    
                }
            }
    }
    
function payoutUser(address payable recipient , address _paymentMethod , uint256 amount) private {
       noneZeroAddress(recipient);
        if (_paymentMethod == address(0)) {
          recipient.transfer(amount);
        } else {
             IERC20 currentPaymentMethod = IERC20(_paymentMethod);
             require(currentPaymentMethod.transfer(recipient , amount) ,"I_F");
        }
    }
   function getAssetSupportedChainIds(address assetAddress) external view returns(uint256[] memory) {
       return assetSupportedChainIds[assetAddress];
   }


   function getAssetCount() external view returns (uint256  , uint256  ) {
       return (nativeAssetsList.length,foriegnAssetsList.length );
       
   }

   function notPaused()private view returns (bool) {
        require(!paused, "B_P");
        return true;        
    }


    function noneZeroAddress(address _address) private pure returns (bool) {
        require(_address != address(0), "A_z");
        return true;
   }



    function onlyAdmin() private view returns (bool) {
        require(controller.isAdmin(msg.sender) || msg.sender == controller.owner() ,"U_A");
        return true;
    }


    function isOwner() internal view returns (bool) {
        require(controller.owner() == _msgSender() , "U_A");
        return true;
    }

     
    function isAssetManager(address assetAddress ,bool native)  internal view returns (bool) {
        bool isManager;
        if (native) {
            if(nativeAssets[assetAddress].manager == _msgSender()  && nativeAssets[assetAddress].manager != address(0)){
                isManager = true;
            } 
        } 
            
        else {
            if(foriegnAssets[assetAddress].manager == _msgSender()  && foriegnAssets[assetAddress].manager != address(0)){
                isManager = true;
            } 
        }
        return isManager;
    }
    

   function bridgeData() external view returns (address , uint256 , uint256){
       return(  feeController , totalFees , feeBalance);
   }

  
  
}

        
