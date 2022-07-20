import path from "path";
import {
  init,
  emulator,
  shallPass,
  sendTransaction,
  getAccountAddress,
} from "@onflow/flow-js-testing";

// We need to set timeout for a higher number, because some transactions might take up some time
jest.setTimeout(10000);

describe("TicTacToe Contract", () => {
  // Instantiate emulator and path to Cadence files
  beforeEach(async () => {
    const basePath = path.resolve(__dirname, "./cadence");
    await init(basePath);
    return emulator.start();
  });

  // Stop emulator, so it could be restarted
  afterEach(async () => {
    return emulator.stop();
  });

  test("basic transaction", async () => {
    const code = `
      transaction(message: String){
        prepare(singer: AuthAccount){
          log(message)
        }
      }
    `;
    const Alice = await getAccountAddress("Alice");
    const signers = [Alice];
    const args = ["Hello, Cadence"];

    const [txResult, error] = await shallPass(
      sendTransaction({
        code,
        signers,
        args,
      })
    );

    // Transaction result will hold status, events and error message
    console.log(txResult, error);
  });
});
