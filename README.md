## Details

The issue occurs when an event is emitted, which satisfies the following conditions:

- Ganache's `subscribedTopics` property contains the event identifier of the event (hash of the event signature)
- Ganache's `contractCache` contains an entry for the address associated with the event
- the contract in the cache does not contain an event matching the event identifier

## Reproduction steps

1. Start Ganache UI with the project loaded
2. Deploy `EventEmitter` contract with `truffle migrate` - grab the contract address which will be used in the next step
3. Remove the build project with `rm -rf build`
4. Comment out `EventEmitter` contract from `DelegateCaller.sol`, update the migration script (as per comments in `1_reproduction.js`), redeploy with `truffle migrate`
5. The migration script `1_reproduction.js` automatically calls `DelegateCaller.delegateCall()` function
6. Click `Events` tab in Ganache-UI

## Explanation:

In step 2. `subscribedtopics` is populated with the Event from `EventEmitter`. `subscribedTopics` is additive, so the subscription is not removed when we redeploy without the `EventEmitter` contract.

In step 5, the event is emitted, and is associated with the `DelegateCaller` address. The preconditions described above are met, specifically:

- `subscribedTopics` must include the event identifier
- The contract cache must have an entry for the address raising the event

The `decoder` returns undefined if no event matching the event identifier is found, triggering the whole kerfuffle.
