import React, { useState } from "react";
import {token} from "../../../declarations/token";

function Faucet() {

  let [isDisabled, setDisable] = useState(false);
  let [buttonText, setButtonText] = useState("Gimme Gimme");

  async function handleClick(event) {
    setDisable(true);
    setButtonText(await token.payOut());
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free BTokens here! Claim 10,000 BTokens to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
