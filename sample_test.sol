import "truffle/Assert.sol";

// In Solidity, when performing a contract call that produces an error,
// Solidity automatically rethrows, meaning it will bubble that error up
// to the caller. However, with a raw call, the behavior is different: one
// can catch the error and decide what to do from there on out. If it throws
// (fails), it will return false. If it succeeds, it will return true.


//Proxy contract for testing throws
contract ThrowProxy {
  address public target;
  bytes data;

  function ThrowProxy(address _target) {
    target = _target;
  }

  //prime the data using the fallback function
  function() {
    data = msg.data;
  }

  function execute() returns (bool){
    return target.call(data);
  }
}

//
