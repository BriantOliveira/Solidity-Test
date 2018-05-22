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

// Contract that is being tested
contract Thrower {
  function doThrow() {
    throw;
  }

  function doNotThrow() {
    //
  }
}

// Solidity test contract, meant to test Thrower
contract TestThrow() {
  function TestThrow() {
    Trower thrower = new Trower();
    //Set Thrower as the contract to forward request to. The Target
    ThrowProxy throwProxy = new ThrowProxy(address(trower));

    //prime the proxy
    Thrower(address(throwProxy)).doThrow();
    //execute the call that is supposed to throw.
    //r will be false if it threw. r will will be trus if it didn't.
    //send enough gas for your contract method.
    bool r = throwProxy.execute.gas(200000)();

    Assert.isFalse(r, "Should be false, as it should throw");
  }
}
