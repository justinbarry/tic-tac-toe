import path from "path";
import {
  init,
  emulator,
  sendTransaction,
  shallPass,
  getAccountAddress,
  deployContractByName,
  getTemplate,
  executeScript
} from "@onflow/flow-js-testing";

// We need to set timeout for a higher number, because some transactions might take up some time
jest.setTimeout(10000);

describe("TicTacToe Contract", () => {
  let basePath;

  // Instantiate emulator and path to Cadence files
  beforeEach(async () => {
    basePath = path.resolve(__dirname, "../cadence");
    await init(basePath);
    return emulator.start();
  });

  // Stop emulator, so it could be restarted
  afterEach(async () => {
    return emulator.stop();
  });

  test("basic transaction", async () => {
    const Alice = await getAccountAddress("Alice");
    const Bernard = await getAccountAddress("Bernard");
    
    await shallPass(deployContractByName({
      name: "TicTacToe",
      to: Alice,
    }));

    await shallPass(sendTransaction({name: 'CreateGameCollection', signer: [Alice]}));
    await shallPass(sendTransaction({name: 'CreateGame', signer: [Bernard], args: [Alice] }));
  });
});
