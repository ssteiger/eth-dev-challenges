import React from "react";
import { Button } from "antd";
import { useContractReader } from "eth-hooks";
import { ethers } from "ethers";

function ScriptView({ readContracts, writeContracts, tx }) {
  // -------------------------------------------------------------------------------------------------------------

  const receivers = ["0x..", "0x.."];
  const value = "123";

  const execute = async () => {
    const messageSenderBalance = await readContracts.BecToken.balanceOf(receivers[0]);
    console.log({ messageSenderBalance: messageSenderBalance.toString() });

    console.log("executing script ...");
    console.log({
      params: {
        receivers,
        value,
      },
    });
    const result = tx(writeContracts.BecToken.batchTransfer(receivers, value, { gasLimit: 100000 }), update => {
      console.log("📡 Transaction Update:", update);
      if (update && (update.status === "confirmed" || update.status === 1)) {
        console.log(" 🍾 Transaction " + update.hash + " finished!");
      }
    });
    console.log("awaiting metamask/web3 confirm result...", result);
    console.log({ result: await result });
  };

  // -------------------------------------------------------------------------------------------------------------

  // you can ignore this
  //
  return (
    <div style={{ marginTop: "5%" }}>
      <div style={{ marginBottom: 25 }}>
        script location:
        <span className="highlight" style={{ marginLeft: 4, padding: 4, borderRadius: 4, fontWeight: "bolder" }}>
          eth-dev-challenges/packages/react-app/src/views/Script.js
        </span>
      </div>

      <Button onClick={() => execute()}>execute script</Button>
    </div>
  );
}

export default ScriptView;
