# PLONK Proof Generation and Verification using Circom

The goal of this hands-on reading is to give you a complete walkthrough of how circom and snarkjs are used to do trusted setup, prover and verifier key generation, proof generation and verification.

A simple circuit to follow all the below steps on, is available [here](circuits/factorisation.circom).

## Steps

### 1. Generate powers of tau

```bash
snarkjs powersoftau new bn128 12 ptau/pot12_0000.ptau -v
```

### 2. Contribute to the ceremony

```bash
snarkjs powersoftau contribute ptau/pot12_0000.ptau ptau/pot12_0001.ptau --name="First contribution" -v
```

### 3. Prepare phase 2 of the ceremony

```bash
snarkjs powersoftau prepare phase2 ptau/pot12_0001.ptau ptau/pot12_final.ptau -v
```

### 4. Compiling the circuit

```bash
circom circuits/factorisation.circom --r1cs --wasm --sym
```

### 5. Generate witness

```bash
node factorisation_js/generate_witness.js factorisation_js/factorisation.wasm input.json witness.wtns
```

### 6. Generate zkey file

```bash
snarkjs plonk setup factorisation.r1cs ptau/pot12_final.ptau factorisation.zkey
```

### 7. Export verification key

```bash
snarkjs zkey export verificationkey factorisation.zkey verification_key.json
```

### 8. Generate ZK proof and json containing public values for verifier

```bash
snarkjs plonk prove factorisation.zkey witness.wtns proof.json public.json
```

### 8. Verify proof

Check that once the command is executed, you get this message in the console `[INFO]  snarkJS: OK!`

```bash
snarkjs plonk verify verification_key.json public.json proof.json
```

### 10. Export verifier contract

Generate the verifier contract in `contracts/` directory

```bash
snarkjs zkey export solidityverifier factorisation.zkey contracts/Verifier.sol
```

## Resources

* [Circom installation](https://docs.circom.io/getting-started/installation/)

* [How to create a Zero Knowledge DApp](https://vivianblog.hashnode.dev/how-to-create-a-zero-knowledge-dapp-from-zero-to-production)

* [Circom Documentation](https://docs.circom.io/getting-started/writing-circuits/)