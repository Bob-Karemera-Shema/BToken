import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor Token{
    var owner: Principal = Principal.fromText("njr2m-r6kza-aetly-julyl-zggjb-fhcrc-6md6f-pndei-3hu5f-pxvce-sqe");
    var totalSupply : Nat = 1000000000;
    var symbol: Text = "BTOKEN";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

    balances.put(owner, totalSupply);

    public query func balanceOf(who: Principal) : async Nat {
        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?output) output;
        };

        return balance;
    }
}