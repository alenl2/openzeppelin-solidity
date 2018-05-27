pragma solidity ^0.4.23;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address[] private _owners;


  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    _owners.push(msg.sender);
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner(msg.sender));
    _;
  }

  function isOwner(address account) internal view returns(bool isOwner){
    isOwner = false;
    for(uint256 i = 0; i < _owners.length; i++){
      if(account == _owners[i]){
        isOwner = true;
        break;
      }
    }
  }

  function owners() public view returns(address[] owners){
    owners = _owners;
  }
  
  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    require(isOwner(newOwner) == false);

    uint pos = _owners.push(newOwner) -1;
    emit OwnershipTransferred(_owners[pos], newOwner);
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   */
  //function renounceOwnership() public onlyOwner {
  //  emit OwnershipRenounced(owner);
  //  owner = address(0);
  //}
}
