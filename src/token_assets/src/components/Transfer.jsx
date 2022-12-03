import React, { useState } from "react";
import {token} from "../../../declarations/token";
import {Principal} from "@dfinity/principal";

function Transfer() {
  
  let [recipientId, setId] = useState("");
  let [amount, setAmount] = useState("");
  let [isDisabled, setDisabled] = useState(false);
  let [feedback, setFeedback] = useState("");
  let [isHidden, setHidden] = useState(true);
  
  async function handleClick() {
    setHidden(true);
    setDisabled(true);
    setFeedback(await token.transfer(Principal.fromText(recipientId), Number(amount)));
    setHidden(false);
    setDisabled(false);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recipientId}
                onChange={(e) => setId(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isDisabled} >
            Transfer
          </button>
        </p>
        <p>{feedback}</p>
      </div>
    </div>
  );
}

export default Transfer;
