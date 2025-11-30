Here’s a plain, fully copyable README with no special markup from this chat system—just standard Markdown you can paste directly into `README.md`:

# Decentralized Auto‑Pay Cardano Subscription Engine

A Cardano-based subscription dApp that lets users lock ADA into a “subscription vault” and stream recurring payments to a merchant. Built for a Cardano hackathon using Next.js, TypeScript, Tailwind CSS, Aiken smart contracts, Lucid, and Blockfrost.

## Features

- Connect Cardano wallets via CIP‑30 (Lace, Eternl, Nami, Flint, Yoroi).
- Testnet support (Pre‑Production or Preview, configurable).
- Create programmable subscriptions:
  - Merchant address (addr_test1…)
  - Amount per period (ADA)
  - Period unit (hourly / daily / weekly / monthly / yearly)
  - Number of periods
- Lock the full subscription amount upfront and show total locked ADA.
- Display active subscriptions with links to Cardano explorer.
- Uses an Aiken validator and Plutus blueprint (plutus.json) for on‑chain logic.

## Tech Stack

- Frontend: Next.js 16, React, TypeScript, Tailwind CSS  
- Smart contracts: Aiken  
- Cardano SDK: Lucid  
- Infrastructure: Blockfrost (testnet)  
- Wallets: Lace, Eternl, Nami, Flint, Yoroi (CIP‑30)

## Project Structure

```text
cardano-sub/                 # Next.js frontend
  pages/
    index.tsx                # Main UI
  components/
    WalletConnect.tsx        # Wallet connection + Lucid init
    SubscriptionForm.tsx     # Create subscription form + tx build
  lib/
    lucid.ts                 # Lucid + Blockfrost helpers
  contracts/
    plutus.json              # Compiled Aiken validator blueprint
  styles/
    globals.css              # Tailwind + global styles
  .env.local                 # Env vars (not committed)

cardano_sub_contract/        # Aiken smart contract project
  validators/                # Aiken source files
  artifacts/                 # Build outputs (usually git‑ignored)
```

## Prerequisites

- Node.js (LTS)
- npm
- Blockfrost account with a Cardano testnet project key
- Cardano wallet extension (recommended: Eternl or Nami)

## Environment Setup

Create `cardano-sub/.env.local`:

```bash
NEXT_PUBLIC_BLOCKFROST_KEY=your_blockfrost_project_key_here
NEXT_PUBLIC_CARDANO_NETWORK=preprod   # or preview
```

Make sure your wallet is on the same network (Pre‑Production testnet or Preview testnet).

## Install and Run

```bash
cd cardano-sub
npm install
npm run dev
```

Then open:

```text
http://localhost:3000
```

## Using the dApp

1. Open your Cardano wallet (Eternl, Nami, etc.) and switch to the correct testnet.  
2. Get some test ADA from a faucet or community faucet.  
3. Visit `http://localhost:3000`.  
4. Click “Connect Wallet” and approve the connection in your wallet.  
5. After connecting you’ll see:
   - Shortened wallet address
   - Testnet ADA balance  
6. Fill in the “Create Subscription” form:
   - Merchant address
   - Amount per period
   - Period unit and number of periods  
7. Confirm the transaction in your wallet.  
8. Once submitted, the transaction hash shows up and the subscription appears in “Your Active Subscriptions” with an explorer link.

## Smart Contract Overview (Aiken)

The Aiken validator models a subscription as a datum containing:

- Merchant key hash  
- Subscriber key hash  
- Amount per period  
- Periods remaining  
- Period length in seconds  
- Next payment timestamp  

The merchant can claim a payment when:

- They sign the transaction  
- The current time is past the `next_payment` timestamp  
- There are remaining periods  

Each successful claim decreases the remaining periods and advances `next_payment`.

## Development Notes

- This repo targets Cardano testnets only (no mainnet by default).  
- Environment files (`.env*`) and build artifacts are ignored via `.gitignore`.  
- `contracts/plutus.json` is committed so the frontend can use the compiled validator.

## Roadmap

- Pause / cancel subscriptions from the UI.  
- Support multiple merchants and plans per user.  
- Add analytics (next due date, history, total paid).  
- Multi‑asset support and NFT‑gated subscriptions.
