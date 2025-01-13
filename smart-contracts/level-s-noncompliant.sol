//vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
//--------//DISCLAIMER: THIS IS A WIP/EXAMPLE.//----------
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

contract LevelSCompliance {
    address public owner;
    bytes data;

    // Added function f() for contract C to call
    function f() public view {}

    // Requirement: [S] No CREATE2
    function create2Contract(bytes32 salt) public {
        address newContract = address(new ContractUsingCreate2{salt: salt}(owner));
    }

    // Requirement: [S] No `tx.origin`
    function useTxOrigin() public returns(address){
        return tx.origin;
    }

    // Requirement: [S] No Exact Balance Check
    function checkBalance(address account) public view returns(bool) {
        return account.balance == 1 ether;
    }

    // Requirement: [S] No Hashing Consecutive Variable Length Arguments
    function hashVariableLength(bytes memory a, bytes memory b) public pure returns(bytes32){
        return keccak256(abi.encodePacked(a,b));
    }

    // Requirement: [S] No selfdestruct()
    function destroy() public {
       selfdestruct(payable(owner));
    }
    
    // Requirement: [S] No assembly()
    function assemblyFunction() public returns(uint result){
        assembly {
            result := add(1, 1)
        }
    }

    // Requirement: [S] No Unicode Direction Control Characters
    string public unicodeString = "This is a test string \u202e with embedded characters";

    // Requirement: [S] Check External Calls Return
    function checkExternalCalls(address externalContract) public {
        (bool success, bytes memory mem ) = externalContract.call(abi.encodeWithSignature("someFunction()"));
        //intentionally skip the check
    }

    // Requirement: [S] Use Check-Effects-Interaction pattern
    mapping(address => uint256) public userBalances;
    bool public locked = false;

    function transferReentrant(address to, uint256 amount) external {
        require(!locked, "Re-entrancy detected");
        locked = true;
        userBalances[msg.sender] -= amount;
        payable(to).transfer(amount);
        userBalances[to] += amount;
        locked = false;
    }

    // Requirement: [S] No delegatecall()
    function delegateCall(address target) public {
        bytes memory payload = abi.encodeWithSignature("someFunction()");
        (bool success, bytes memory mem ) = target.delegatecall(payload);
    }
    
    // Requirement: [S] Explicit storage allocation
    uint256 public a;
    struct MyStruct {
        uint256 b;
    }

    MyStruct internal myStruct;

    function setValues(uint256 _a, uint256 _b) external {
        a = _a;
        myStruct.b = _b;
    }

    // Requirement: [S] Explicit constructors
    uint public immutableConstructor;
    constructor() {
        immutableConstructor = 1;
    }


    // Requirement: [S] Compiler Bug SOL-2022-3
    function testNestedDataLocationBug() public {
        C c = new C();
        c.g(this);
    }
    
    // Requirement: [S] Compiler Bug SOL-2022-2
    function testNestedArrayBug(uint[] memory a) public returns (uint) {
        uint[][] memory b = new uint[][](1);
        b[0] = a;
        return callWithArray(b);
    }

    function callWithArray(uint[][] memory arg) public pure returns (uint) {
        return arg[0][0];
    }

    // Requirement: [S] Compiler Bug SOL-2022-1
    function testAbiEncodeCallBytesBug() public view {
        bytes memory bytesTest = bytes("test");
        // Removed invalid abi.encodeCall usage
    }

    // Requirement: [S] Compiler Bug SOL-2021-4
    struct MyValue {
        uint160 value;
    }
    function testCustomValueBug(MyValue memory a) public {
        MyValue memory c;
    }

    // Requirement: [S] Compiler Bug SOL-2021-2
    function testAbiDecodeBug() public returns (bytes memory) {
        bytes memory t = hex"000000010203";
        bytes memory tt = abi.decode(t,(bytes));
        return tt;
    }

    // Requirement: [S] Compiler Bug SOL-2020-9
    function testFreeFunction() public {
        uint[] memory arr = new uint[](10);
        for (uint i=0; i < 10; i++) {
            arr[i] = i;
        }
        uint total = sum(arr);
    }

    function sum(uint[] memory arr) public pure returns(uint s) {
        for (uint i = 0; i < arr.length; i++)
            s += arr[i];
    }

    // Requirement: [S] Compiler Bug SOL-2020-8
    function testExternalCallWithAssembly(address lib) public {
        bytes memory payload = abi.encodeWithSignature("someFunc(uint256)");
        uint result;
        assembly{
            let success := call(gas(), lib, 0, add(payload,0x20), mload(payload), 0, 32)
            result := mload(returndatasize())
        }
    }

    // Requirement: [S] Compiler Bug SOL-2020-6
    function testCompilerVersion() public {
        uint8 x = 1;
        uint8 y = 2;
    }

    // Requirement: [S] Compiler Bug SOL-2020-7
    struct testStruct {
        uint256[] a;
    }
    function testStructsInFunctions(testStruct memory str) public returns(testStruct memory) {
        return str;
    }
    
    // Requirement: [S] Compiler Bug SOL-2020-5
    mapping (address => uint) public balancePerPerson;
    function TestPayableConstructor() payable public {
        balancePerPerson[msg.sender] += msg.value;
    }

    // Requirement: [S] Compiler Bug SOL-2020-4
    struct X { bytes a; }
    struct Y { X x; }
    function f(Y memory y, uint x) public returns (bytes memory) {
        return abi.encodePacked(y.x.a, x);
    }

    // Requirement: [S] Compiler Bug SOL-2020-3
    struct MyRec2 {
        uint a;
        uint b;
    }
    function returnStruct(MyRec2 memory s) public returns (MyRec2 memory) {
        MyRec2[1] memory arr;
        arr[0] = s;
        return arr[0];
    }

    // Requirement: [S] Compiler Bug SOL-2020-1
    struct Data {
        mapping (bytes32 => uint) data;
        uint[] moreData;
    }

    // Requirement: [S] Compiler Bug SOL-2019-10
    function encodePackedCall(string memory s) public pure returns (bytes memory) {
        return abi.encodePacked(s, uint256(0));
    }

    // Requirement: [S] Compiler Bugs SOL-2019-3,6,7,9
    function testCompilerVersion3679() public {
        uint256 x = 1;
        uint y = 2;
    }
    
    // Requirement: [S] Compiler Bug SOL-2019-8
    function testThisCallAsParam(uint x) public view returns (bytes32) {
        return keccak256(abi.encode(x, address(this)));
    }

    // Requirement: [S] Compiler Bug SOL-2019-5
    function testFunctionPointer(address contractAddress) external {
        ContractToTest(contractAddress).testA(1);
    }
        
    // Requirement: [S] Compiler Bug SOL-2019-4
    struct testReturn {
        uint a;
    }
    function testReturnWithInheritance(address contractAddress) public returns (testReturn memory) {
        return ContractToTest(contractAddress).testB();
    }

    // Requirement: [S] Compiler Bug SOL-2019-2
    function testAssembly(uint test) public returns (uint result) {
        assembly {
            let success := call(gas(),address(),0,test,0x20,0,0)
            result := mload(returndatasize())
        }
    }

    // Requirement: [S] Compiler Bug SOL-2018-4
    struct MyStruct2 {uint a;}
    function testNestedStructReturns() public returns (MyStruct2 memory, uint) {
        MyStruct2 memory result = MyStruct2({a:1});
        return (result,1);
    }

    // Requirement: [S] Compiler Bug SOL-2018-3
    event EventWithAddressInStruct(TestAddress myaddress);
    struct TestAddress {
        address add;
    }
    function testStructAddress() public returns(address) {
        TestAddress memory myAdd = TestAddress(owner);
        emit EventWithAddressInStruct(myAdd);
        return owner;
    }

    // Requirement: [S] Compiler Bug SOL-2018-2
    struct testNestedStructs {
        mapping(address => MyStruct) someMapping;
        MyStruct[] nestedArr;
    }

    // Requirement: [S] Compiler Bug SOL-2018-1
    struct TestBytes {
        bytes b;
    }

    function testBytesCallData (TestBytes memory input) external view returns (uint) {
        uint length = input.b.length;
        return length;
    }

    // Requirement: [S] Compiler Bug SOL-2017-5
    event TestIndexed(string indexed test);
    function testIndexedEvent(string memory test) external {
        emit TestIndexed(test);
    }
    
    // Requirement: [S] Compiler Bug SOL-2017-3
    function testMapping(address owner) public returns (uint256) {
        MyRec2 memory s = MyRec2(1,1);
        MyRec2 memory returned = returnStruct(s);
        return returned.a;
    }

    // Requirement: [S] Compiler Bug SOL-2017-2
    function callWithEmptyString(string memory test) public {
        someOtherFunction(test);
    }
    
    function someOtherFunction(string memory test) private {}

}

contract ContractUsingCreate2 {
    address public owner;
    constructor(address _owner) {
        owner = _owner;
    }
    event Created(address _owner);
}

interface ContractToTest {
    function testA(uint x) external;
    function testB() external returns (LevelSCompliance.testReturn memory);
}

contract C {
    function g(LevelSCompliance c) public {
        c.f();
    }
}

interface TestAddress {
    function testB() external;
}