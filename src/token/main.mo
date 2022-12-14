import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor Token{
    let owner: Principal = Principal.fromText("njr2m-r6kza-aetly-julyl-zggjb-fhcrc-6md6f-pndei-3hu5f-pxvce-sqe");
    let totalSupply : Nat = 1000000000;
    let symbol: Text = "BTOKEN";

    private stable var balanceEntries: [(Principal, Nat)] = [];

    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    if(balances.size() < 1) {
        balances.put(owner, totalSupply);
    };

    public query func balanceOf(who: Principal) : async Nat {
        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?output) output;
        };

        return balance;
    };

    public query func getSymbol() : async Text {
        return symbol;
    };

    public shared(msg) func payOut() : async Text {

        if(balances.get(msg.caller) == null) {
            return await transfer(msg.caller, 10000);
        } else {
            return "Free BTokens already claimed";
        }
    };

    public shared(msg) func transfer(to: Principal, amount: Nat): async Text{
        let fromBalance = await balanceOf(msg.caller);

        if(fromBalance > amount) {
            let newFromBalance: Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);
            
            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success";
        } else {
            return "Insufficient funds";
        }
    };

    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entries())
    };

    system func postupgrade() {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);

        if(balances.size() < 1){
            balances.put(owner, totalSupply);
        }
    };
}