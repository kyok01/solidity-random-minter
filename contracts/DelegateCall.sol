// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num)
        public
        payable
        returns (uint256)
    {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        // If the function call succeeded
        // if (success) {
        //     // We know that "myFunction" returns an
        //     // uint256 so we decode it and return it.
        //     return abi.decode(data, (uint256));
        // } else {
        //     // If function did not succeed then revert with
        //     // error message if there is one.
        //     if (data.length > 0) {
        //         // bubble up the error
        //         revert(string(data));
        //     } else {
        //         revert("myFunction had an error");
        //     }
        // }
    }
}